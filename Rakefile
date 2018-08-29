require 'semver'

BUILD_SDK = ENV['BUILD_SDK'] || 'iphonesimulator11.2'
EXAMPLE_WORKSPACE = 'Example/Backpack.xcworkspace'
EXAMPLE_SCHEMA = 'Backpack Native'
VERSION_FORMAT = '%M.%m.%p%s%d'
PODSPEC = 'Backpack.podspec'

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


task :test do
  sh "set -o pipefail && xcodebuild test -enableCodeCoverage YES -workspace #{EXAMPLE_WORKSPACE} -scheme \"#{EXAMPLE_SCHEMA}\" -sdk #{BUILD_SDK} -destination \"platform=iOS Simulator,name=iPhone 8\" ONLY_ACTIVE_ARCH=NO | xcpretty"
end

task :lint do
  sh "bundle exec pod lib lint"
end

task ci: [:lint, :test]

# task release: :test do
task release: :ci do
  abort red 'Must be on master branch' unless current_branch == 'master'
  abort red 'Must have push access to Backpack on CocoaPods trunk' unless has_trunk_push
  abort red 'Git branch is not up to date please pull' unless branch_up_to_date


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
  sh "bundle exec jazzy -o #{args.outputDir} --objc --author Backpack --umbrella-header Backpack/Classes/Backpack.h --framework-root Backpack --module Backpack --skip-undocumented"
end

# Helpers
def green(string)
  "\033[0;32m#{string}\e[0m"
end

def red(string)
  "\033[0;31m#{string}\e[0m"
end
