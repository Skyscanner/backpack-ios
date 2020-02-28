require 'fileutils'
require 'semver'

FULL_TESTS = ENV['FULL_TESTS'] != 'false'
BUILD_SDK = ENV['BUILD_SDK'] || 'iphonesimulator13.3'
TEST_DEVICE_NAME = ENV['TEST_DEVICE_NAME'] || 'iPhone 8'
DESTINATION = ENV['DESTINATION'] || 'platform=iOS Simulator,name=iPhone 8'
EXAMPLE_WORKSPACE = 'Example/Backpack.xcworkspace'
EXAMPLE_SCHEMA = 'Backpack Native'
UNIT_TEST_SCHEMA = 'Backpack Native Unit Tests'
VERSION_FORMAT = '%M.%m.%p%s%d'
PODSPEC = 'Backpack.podspec'
MAX_TEST_REPEATS = 3
ANALYZE_FAIL_MESSAGE = '⚠️'

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
  `#{command}`
  if $?.exitstatus == 0
    puts "Process succeeded on attempt #{run_count}."
  else
    repeat_on_fail(command, run_count + 1)
  end
end

def install_pods_in_example_project()
  `(cd Example && bundle exec pod install)`
  $?.exitstatus == 0
end

def get_changed_files()
  `git status --porcelain | grep -Ev "CHANGELOG|UNRELEASED|package-lock.json"`.lines
end

def check_pristine()
  changes = get_changed_files
  changes.length == 0
end

namespace :git do
  task :fetch do
    `git fetch`
  end
end

task :analyze do
  sh "set -o pipefail && ! xcodebuild -workspace #{EXAMPLE_WORKSPACE} -scheme \"#{EXAMPLE_SCHEMA}\" -sdk #{BUILD_SDK} -destination \"#{DESTINATION}\" ONLY_ACTIVE_ARCH=NO analyze 2>&1 | xcpretty | grep -v Pods/TTTAttributedLabel/TTTAttributedLabel/ | grep -v Pods/OCMock/ | grep -v Pods/MBProgressHUD/ | grep -A 5 \"#{ANALYZE_FAIL_MESSAGE}\""
end

task :erase_devices do
  sh "pkill Simulator && xcrun simctl erase all"
end

task :test do
  only_testing = FULL_TESTS ? '' : '-only-testing:Backpack_Tests'
  test_command = "set -o pipefail && xcodebuild test -enableCodeCoverage YES -workspace #{EXAMPLE_WORKSPACE} -scheme \"#{EXAMPLE_SCHEMA}\" -sdk #{BUILD_SDK} -destination \"#{DESTINATION}\" #{only_testing} ONLY_ACTIVE_ARCH=NO | xcpretty"
  repeat_on_fail(test_command)
end

task :lint do
  abort red "The following generated files have changed during setup:\n#{get_changed_files}" unless check_pristine
  `clang-format -i **/*.h **/*.m`
  abort red "clang-format has changed the following files:\n#{get_changed_files}" unless check_pristine
  sh "bundle exec pod lib lint --allow-warnings"
end

task :take_screenshots do
  # Remove existing screenshots
  FileUtils.rm_rf('screenshots')

  sh "xcrun simctl boot \"#{TEST_DEVICE_NAME}\""
  sh "xcrun simctl status_bar \"#{TEST_DEVICE_NAME}\" override --time \"0941\" --wifiBars 3 --cellularBars 4 --batteryLevel 100"
  sh "(cd Example && fastlane snapshot)"
  FileUtils.mv(Dir.glob('screenshots/en-US/*'), 'screenshots/')
end

task ci: [:erase_devices, :all_checks]
task all_checks: [:lint, :analyze, :test]

task :release_no_checks do
  abort red 'Must be on master branch' unless current_branch == 'master'
  abort red 'Must have push access to Backpack on CocoaPods trunk' unless has_trunk_push
  abort red 'Git branch is not up to date please pull' unless branch_up_to_date

  sh "npm ci"
  sh "npx gulp"
  abort red 'Gulp task has made changes to source. Ensure these are intentional and commit them before releasing.' unless check_pristine

  version = SemVer.parse(last_version)
  puts "Starting new release. Previous version was #{green(version)}"
  change = ask "What semver change do you wanna make? (major, minor, patch, custom)" do |input|
    symbolized = input.downcase.to_sym
    symbolized if [:major, :minor, :patch, :custom].include?(symbolized)
  end

  case change
  when :major
    version.major += 1
    version.minor = 0
    version.patch =0
  when :minor
    version.minor += 1
    version.patch = 0
  when :patch
    version.patch += 1
  when :custom
    version = ask "Enter custom semver version" do |input|
      parsed = SemVer.parse(input.strip)
      parsed unless parsed.nil?
    end
  end

  puts "New version will be #{green(version)}"

  version_string = version.format(VERSION_FORMAT)
  puts "Updating podspec."
  contents = File.read(PODSPEC)
  contents.gsub!(/s\.version\s*=\s(:?'|")\d+\.\d+\.\d+(-\w+\.\d)?(:?'|")/, "s.version          = \"#{version_string}\"")
  File.open(PODSPEC, 'w') { |file| file.puts contents }
  abort red "Podspec should have been updated with the new version, but it wasn't." unless file_is_dirty(PODSPEC)

  has_changelog_entry = !(%x{cat CHANGELOG.md | grep #{version_string}}.chomp.empty?)
  abort red "No entry for version #{version_string} in CHANGELOG.md" unless has_changelog_entry
  abort red "Installing pods in the Example project failed" unless install_pods_in_example_project

  puts "Comitting, tagging, and pushing"
  message = "[Release] Version #{version_string}"
  sh "git commit -am '#{message}'"
  sh "git tag #{version_string} -m '#{message}'"
  sh "git push  --follow-tags"

  puts "Pushing to CocoaPods trunk."
  sh "bundle exec pod trunk push #{PODSPEC} --allow-warnings"

  puts green("🎉 All went well. Version #{version_string} published.")
end

task release: ['git:fetch', :all_checks, :release_no_checks]

task :docs, :outputDir do |t, args|
  args.with_defaults(:outputDir => "docs")
  sh "bundle exec jazzy -o #{args.outputDir} --objc --author Backpack --umbrella-header Backpack/Backpack.h --framework-root Backpack --module Backpack --skip-undocumented --sdk iphonesimulator"
end

# Helpers
def green(string)
  "\033[0;32m#{string}\e[0m"
end

def red(string)
  "\033[0;31m#{string}\e[0m"
end
