#!/usr/bin/env ruby

org_files = Dir["./**/*.org"].map{ |f| File.basename(f, ".org") }

puts org_files

# export pandoc
org_files.each do |org_file|
  system "pandoc -s #{org_file}.org -o #{org_file}.md"
end

