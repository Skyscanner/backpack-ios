require 'fileutils'
require 'semver'

BUILD_SDK = ENV['BUILD_SDK'] || 'iphonesimulator15.2'
TEST_DEVICE_NAME = ENV['TEST_DEVICE_NAME'] || 'iPhone 8'
DESTINATION = ENV['DESTINATION'] || 'platform=iOS Simulator,name=iPhone 8'
EXAMPLE_WORKSPACE = 'Example/Backpack.xcworkspace'
EXAMPLE_SCHEME = 'Backpack Native'
SWIFTUI_SCHEME = 'Backpack SwiftUI'
COMMON_SCHEME = 'Backpack-Common'
UNIT_TEST_SCHEMA = 'Backpack Native Unit Tests'
VERSION_FORMAT = '%M.%m.%p%s%d'
UIKIT_PODSPEC = 'Backpack.podspec'
SWIFTUI_PODSPEC = 'Backpack-SwiftUI.podspec'
COMMON_PODSPEC = 'Backpack-Common.podspec'
MAX_TEST_REPEATS = 3
ANALYZE_FAIL_MESSAGE = '⚠️'
SWIFT = ENV['SWIFT'] || '5.0'

def ask(question)
  valid_input = true
  begin
    puts question
    print '> '
    input = STDIN.gets.chomp.strip
    valid_input = yield input if block_given?
    puts
  end until valid_input
  valid_input
end

def has_trunk_push
  result = `bundle exec pod trunk me`
  $?.exitstatus == 0 && result.chomp.include?('Backpack')
end

def last_version
  %x{git describe --abbrev=0 --tags}
end

def current_branch
  %x{git rev-parse --abbrev-ref HEAD}.strip
end

def branch_up_to_date
  `git remote update && git status -uno | grep -q -v 'Your branch is behind'`
  $?.exitstatus == 0
end

def file_is_dirty(filename)
  `git diff --exit-code --name-only #{filename}`
  $?.exitstatus != 0
end

def repeat_on_fail(command, run_count = 1)
  if run_count > MAX_TEST_REPEATS
    puts "Process is still failing after #{MAX_TEST_REPEATS} attempts.\n Giving up."
    abort "Tests failed."
  end

  puts "Running process. This is attempt #{run_count} of #{MAX_TEST_REPEATS}."
  sh command
  if $?.exitstatus == 0
    puts "Process succeeded on attempt #{run_count}."
  else
    repeat_on_fail(command, run_count + 1)
  end
end

namespace :git do
  task :fetch do
    `git fetch`
  end
end

desc "Check for build-time errors and warnings"
task :analyze, [:scheme] do |t, args|
  sh "set -o pipefail && xcodebuild -workspace #{EXAMPLE_WORKSPACE} -scheme \"#{args[:scheme]}\" SWIFT_VERSION=#{SWIFT} -sdk #{BUILD_SDK} -destination \"#{DESTINATION}\" ONLY_ACTIVE_ARCH=YES analyze 2>&1 | xcpretty"
end

desc "Run unit tests up to #{MAX_TEST_REPEATS} times until they pass"
task :test, [:scheme] do |t, args|
  test_command = "set -o pipefail && xcodebuild test -enableCodeCoverage YES -workspace #{EXAMPLE_WORKSPACE} -scheme \"#{args[:scheme]}\" SWIFT_VERSION=#{SWIFT} -sdk #{BUILD_SDK} -destination \"#{DESTINATION}\" ONLY_ACTIVE_ARCH=YES | xcpretty"
  repeat_on_fail(test_command)
end

desc "Takes screenshots of all components in both light and dark mode"
task :take_screenshots do
  # Remove existing screenshots
  FileUtils.rm_rf('screenshots')

  sh "(cd Example && bundle exec fastlane snapshot)"
  FileUtils.mv(Dir.glob('screenshots/en-US/*'), 'screenshots/')
end

task :git_checks do
  abort red 'Must be on main branch' unless current_branch == 'main' or current_branch.start_with?('fix/')
  abort red 'Must have push access to Backpack on CocoaPods trunk' unless has_trunk_push
  abort red 'Git branch is not up to date please pull' unless branch_up_to_date
end

task :check_changelog_version, [:version] do |t, args|
  version_string = args[:version]
  has_changelog_entry = !(%x{cat CHANGELOG.md | grep #{version_string}}.chomp.empty?)
  abort red "No entry for version #{version_string} in CHANGELOG.md" unless has_changelog_entry
end

task :push_tag, [:version] do |t, args|
  puts "Comitting, tagging, and pushing"
  version_string = args[:version]
  message = "[Release] Version #{version_string}"
  sh "git commit -am '#{message}'"
  sh "git tag #{version_string} -m '#{message}'"
  sh "git push  --follow-tags"
end

task :push_all_modules_cocoapods_trunk do
  task(:push_cocoapods_trunk).invoke(COMMON_PODSPEC)
  task(:push_cocoapods_trunk).reenable
  task(:push_cocoapods_trunk).invoke(UIKIT_PODSPEC)
  task(:push_cocoapods_trunk).reenable
  task(:push_cocoapods_trunk).invoke(SWIFTUI_PODSPEC)
end

task :push_cocoapods_trunk, [:podspec] do |t, args|
  puts "Pushing #{args[:podspec]} to CocoaPods trunk."
  sh "bundle exec pod trunk push #{args[:podspec]} --allow-warnings"
end

task :update_all_modules_version_in_podspec, [:version] do |t, args|
  version_string = args[:version]
  task(:update_version_in_podspec).invoke(COMMON_PODSPEC, version_string)
  task(:update_version_in_podspec).reenable
  task(:update_version_in_podspec).invoke(UIKIT_PODSPEC, version_string)
  task(:update_version_in_podspec).reenable
  task(:update_version_in_podspec).invoke(SWIFTUI_PODSPEC, version_string)
end

task :update_version_in_podspec, [:podspec_file, :version] do |t, args|
  puts "Updating podspec #{args[:podspec_file]}"
  contents = File.read(args[:podspec_file])
  contents.gsub!(/s\.version\s*=\s(:?'|")\d+\.\d+\.\d+(-\w+\.\d)?(:?'|")/, "s.version          = \"#{args[:version]}\"")
  File.open(args[:podspec_file], 'w') { |file| file.puts contents }
  abort red "Podspec should have been updated with the new version, but it wasn't." unless file_is_dirty(args[:podspec_file])
end

desc "Build the static API docs"
task :docs, :outputDir do |t, args|
  args.with_defaults(:outputDir => "docs")
  documentBackpack(args.outputDir)
  documentSwiftUI(args.outputDir)
end

def documentSwiftUI(output)
  sh "sourcekitten doc -- -workspace #{EXAMPLE_WORKSPACE} -scheme Backpack-SwiftUI > swiftDoc-swiftui.json"
  sh "jazzy --sourcekitten-sourcefile swiftDoc-swiftui.json -o #{output}/swiftui"
  File.delete("swiftDoc-swiftui.json")
end

def documentBackpack(output)
  sh "sourcekitten doc -- -workspace #{EXAMPLE_WORKSPACE} -scheme Backpack > swiftDoc.json"
  createHeaderDoc
  sh "sourcekitten doc --objc $(pwd)/Backpack/BackpackDocHeaders.h -- -x objective-c -isysroot $(xcrun --show-sdk-path --sdk iphonesimulator) -I $(pwd) -fmodules > objcDocs.json"
  sh "jazzy --sourcekitten-sourcefile objcDocs.json,swiftDoc.json -o #{output}/uikit"
  
  File.delete("Backpack/BackpackDocHeaders.h")
  File.delete("objcDocs.json")
  File.delete("swiftDoc.json")
end

def createHeaderDoc()
  hFiles = File.readlines('Backpack/Backpack.h')
  .select {|l| l.start_with?("#import") }
  .map {|i| i.gsub("#import \"","")}
  .map {|i| i.gsub(".h\"\n","")}
  .map {|i| "#import \"#{i}/Classes/#{i}.h\""}
  File.write('Backpack/BackpackDocHeaders.h', hFiles.join("\n"))
end

# Helpers
def green(string)
  "\033[0;32m#{string}\e[0m"
end

def red(string)
  "\033[0;31m#{string}\e[0m"
end
