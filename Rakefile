require 'semver'

FULL_TESTS = ENV['FULL_TESTS'] != 'false'
BUILD_SDK = ENV['BUILD_SDK'] || 'iphonesimulator12.1'
DESTINATION = ENV['DESTINATION'] || 'platform=iOS Simulator,name=iPhone 8'
EXAMPLE_WORKSPACE = 'Example/Backpack.xcworkspace'
EXAMPLE_SCHEMA = 'Backpack Native'
UNIT_TEST_SCHEMA = 'Backpack Native Unit Tests'
VERSION_FORMAT = '%M.%m.%p%s%d'
PODSPEC = 'Backpack.podspec'
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

def install_pods_in_example_project()
  `(cd Example && bundle exec pod install)`
  $?.exitstatus == 0
end

def check_pristine()
  changes = `git status --porcelain | grep -Ev "CHANGELOG|UNRELEASED"`.lines
  changes.length == 0
end

task :analyze do
  sh "set -o pipefail && ! xcodebuild -workspace #{EXAMPLE_WORKSPACE} -scheme \"#{EXAMPLE_SCHEMA}\" -sdk #{BUILD_SDK} -destination \"platform=iOS Simulator,name=iPhone 8\" ONLY_ACTIVE_ARCH=NO analyze 2>&1 | xcpretty | grep -A 5 \"#{ANALYZE_FAIL_MESSAGE}\""
end

task :test do
  only_testing = FULL_TESTS ? '' : '-only-testing:Backpack_Tests'
  sh "set -o pipefail && xcrun simctl erase all && xcodebuild test -enableCodeCoverage YES -workspace #{EXAMPLE_WORKSPACE} -scheme \"#{EXAMPLE_SCHEMA}\" -sdk #{BUILD_SDK} -destination \"#{DESTINATION}\" #{only_testing} ONLY_ACTIVE_ARCH=NO | xcpretty"
end

task :lint do
  sh "bundle exec pod lib lint"
end

task ci: [:lint, :analyze, :test]

# task release: :test do
task release: :ci do
  abort red 'Must be on master branch' unless current_branch == 'master'
  abort red 'Must have push access to Backpack on CocoaPods trunk' unless has_trunk_push
  abort red 'Git branch is not up to date please pull' unless branch_up_to_date

  sh "npm ci"
  sh "npx gulp"
  abort red 'Gulp task has made changes to source. Ensure these are intentional and commit them before releasing.' unless check_pristine

  version = SemVer.parse(last_version)
  puts "Starting new release. Previous version was #{green(version)}"
  change = ask "What semver change do you wanna make? (major, minor, patch)" do |input|
    symbolized = input.downcase.to_sym
    symbolized if [:major, :minor, :patch].include?(symbolized)
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
  sh "bundle exec pod trunk push #{PODSPEC}"

  puts green("🎉 All went well. Version #{version_string} published.")
end

task :docs, :outputDir do |t, args|
  args.with_defaults(:outputDir => "docs")
  sh "bundle exec jazzy -o #{args.outputDir} --objc --author Backpack --umbrella-header Backpack/Backpack.h --framework-root Backpack --module Backpack --skip-undocumented"
end

# Helpers
def green(string)
  "\033[0;32m#{string}\e[0m"
end

def red(string)
  "\033[0;31m#{string}\e[0m"
end
