#!/usr/bin/env ruby

require 'fileutils'

def get_dt_filename(orig_filename)
  cmd = "exiftool \"#{orig_filename}\""
  if orig_filename =~ /jpg/
    ext = 'jpg'
  elsif orig_filename =~ /mp4/
    ext = 'mp4'
  elsif orig_filename =~ /mov/
    ext = 'mov'
  else
    puts "extension not recognizable for #{orig_filename}"
  end

  result = `#{cmd}`
  lines = result.split("\n")

  lines.each do |line|
    if line =~ /File Modification Date/
      match = /(\d{4}):(\d{2}):(\d{2}) (\d{2}):(\d{2}):(\d{2})/.match(line)
      if match
        filename = "#{match[1]}-#{match[2]}-#{match[3]} #{match[4]}.#{match[5]}.#{match[6]}.#{ext}"
        return filename
      else
        puts "no match found for #{line}"
      end
    end
  end
end

if ARGV.size < 2
  $stderr.puts "usage: #{$0} <source> <destination>"
  exit 1
end

input_dir = ARGV[0]
output_dir = ARGV[1]
puts "input dir is #{input_dir} output is #{output_dir}"
if !Dir.exists?(input_dir)
  puts "directory #{input_dir} doesn't exist"
  exit 1
end

if !Dir.exists?(output_dir)
  puts "directory #{output_dir} doesn't exist"
  exit 1
end

Dir.chdir(input_dir)
files = Dir.glob("*.{jpg,mp4,mov}")
fname_map = {}
files.each do |file|
  dt = get_dt_filename(file)
  fname_map[file] = dt
end

fname_map.each do |key, val|
  src = input_dir + key
  dst = output_dir + val
  FileUtils.copy_file(src, dst, preserve = true)
end
