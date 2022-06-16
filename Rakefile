require 'fileutils'

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
