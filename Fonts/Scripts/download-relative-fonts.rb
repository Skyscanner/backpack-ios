#!/usr/bin/env ruby

# This script pulls Skyscanner fonts only if `BPK_USE_RELATIVE=1`.
# It adds them to the `Fonts` pod to make them available to the Example app build.

require 'fileutils'

if ENV["BPK_USE_RELATIVE"] == "1"
  puts "Attempting to pull Skyscanner fonts."
  FileUtils.mkdir_p 'bpk-fonts-tmp'
  Dir.chdir("bpk-fonts-tmp") do
    system "git init"
    system "git remote add origin git@github.skyscannertools.net:backpack/bpk-fonts.git"
    system "git config core.sparsecheckout true"
    system "echo \"iOS\" >> .git/info/sparse-checkout"
    font_success = system "git pull --depth=2 origin main"
    raise "Unable to download Skyscanner fonts." unless font_success
    puts "Skyscanner fonts successfully installed."
  end
else
  puts "Skipping setup of Skyscanner fonts. System fonts will be used instead."
end

FileUtils.mkdir_p 'Assets'
FileUtils.cp Dir.glob('./bpk-fonts-tmp/iOS/SkyscannerRelativeiOS*'), './Assets/'
FileUtils.rm_rf 'bpk-fonts-tmp'
