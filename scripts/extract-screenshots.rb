#!/usr/bin/env ruby

puts "Finding xcresult data...\n"

currentDir = Dir.pwd
backpackDerivedDataDir = nil
derivedDataPath = File.expand_path("~/Library/Developer/Xcode/DerivedData/")
derivedDataFiles = Dir.entries(derivedDataPath)
derivedDataFiles.each do |file|
  if file.include? "Backpack-"
    if backpackDerivedDataDir == nil 
      backpackDerivedDataDir = file
    else
      abort "More than one directory called \"Backpack-...\" in derived data. Clear derived data and try again."
    end
  end
end

abort "No derived data found for Backpack" unless backpackDerivedDataDir != nil

testLogsDir = File.join(derivedDataPath, backpackDerivedDataDir, "/Logs/Test/")
xcresultFileNames = Dir.entries(testLogsDir)
xcresultFileName = xcresultFileNames.sort.last(1)
xcresultFile = File.join(testLogsDir, xcresultFileName)

puts "Finding screenshots directory...\n"

targetScreenshotDirectory = File.join(currentDir, "/screenshots/")

isDarkMode = false

if ARGV.length > 0 && ARGV[0] == "DarkMode"
  isDarkMode = true
end

abort "Target screenshot directory must be a valid directory" unless Dir[targetScreenshotDirectory] != nil
tmpScreenshotDir = File.join(targetScreenshotDirectory, "tmp")

Dir.mkdir(tmpScreenshotDir)
parseCommand = "xcparse -s \"#{xcresultFile}\" \"#{tmpScreenshotDir}\""
system parseCommand

extractedImageDir = File.join(tmpScreenshotDir, "testScreenshots")
images = Dir["#{extractedImageDir}/**/*.png"]

puts "Moving images...\n"

images.each do |image|
  fileNameShort = File.basename(image)
  componentName = fileNameShort.split("_")[0]
  scenarioName = fileNameShort.split("_")[1]
  if isDarkMode
    scenarioName = "#{scenarioName}_dm"
  end
  destinationFile = File.join(targetScreenshotDirectory, componentName, "#{scenarioName}.png")
  moveCommand = "mv \"#{image}\" \"#{destinationFile}\""
  system moveCommand
end

puts "Cleaning up...\n"

system "rm -rf \"#{tmpScreenshotDir}\""

puts "All done 🎉...\n"
