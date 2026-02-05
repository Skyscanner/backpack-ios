#!/usr/bin/env ruby

# This script pulls Skyscanner fonts only if `BPK_USE_RELATIVE=1`.
# It adds them to the `Backpack-Fonts` pod to make them available to the Example app build.

require 'fileutils'

if ENV["BPK_USE_RELATIVE"] == "1"
  puts "Attempting to pull Skyscanner fonts."
  FileUtils.rm_rf 'bpk-fonts-tmp'
  FileUtils.mkdir_p 'bpk-fonts-tmp'
  Dir.chdir("bpk-fonts-tmp") do
    system "git init > /dev/null 2>&1"
    system "git remote add origin git@github.com:Skyscanner/bpk-fonts.git > /dev/null 2>&1"
    system "git config core.sparsecheckout true > /dev/null 2>&1"
    system "echo \"iOS\" >> .git/info/sparse-checkout 2>&1"
    font_success = system "git pull --depth=2 origin main > /dev/null 2>&1"
    unless font_success
      puts "Warning: Unable to download Skyscanner fonts (private repository access required)."
      puts "System fonts will be used instead."
      FileUtils.rm_rf '../bpk-fonts-tmp'
      exit 0
    end
    puts "Skyscanner fonts successfully installed."
  end

  FileUtils.mkdir_p 'Assets'
  if Dir.glob('./bpk-fonts-tmp/iOS/SkyscannerRelativeiOS*').any?
    FileUtils.cp Dir.glob('./bpk-fonts-tmp/iOS/SkyscannerRelativeiOS*'), './Assets/'
  end
  FileUtils.rm_rf 'bpk-fonts-tmp'
else
  puts "Skipping setup of Skyscanner fonts. System fonts will be used instead."
end
