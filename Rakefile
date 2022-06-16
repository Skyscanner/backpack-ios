require 'fileutils'

EXAMPLE_WORKSPACE = 'Example/Backpack.xcworkspace'

desc "Takes screenshots of all components in both light and dark mode"
task :take_screenshots do
  # Remove existing screenshots
  FileUtils.rm_rf('screenshots')

  sh "(cd Example && bundle exec fastlane snapshot)"
  FileUtils.mv(Dir.glob('screenshots/en-US/*'), 'screenshots/')
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
