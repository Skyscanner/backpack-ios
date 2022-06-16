require 'fileutils'

EXAMPLE_WORKSPACE = 'Example/Backpack.xcworkspace'

desc "Takes screenshots of all components in both light and dark mode"
task :take_screenshots do
  # Remove existing screenshots
  FileUtils.rm_rf('screenshots')

  sh "(cd Example && bundle exec fastlane snapshot)"
  FileUtils.mv(Dir.glob('screenshots/en-US/*'), 'screenshots/')
end

desc "Create documentation headers for objc components"
task :create_documentation_headers do
  headers = File.readlines('Backpack/Backpack.h')
  .select {|l| l.start_with?("#import") }
  .map {|i| i.gsub("#import \"","")}
  .map {|i| i.gsub(".h\"\n","")}
  .map {|i| "#import \"#{i}/Classes/#{i}.h\""}
  .join("\n")
  File.write('Backpack/BackpackDocHeaders.h', headers)
end
