#!/usr/bin/ruby

input_list = "/Users/luke/Desktop/Album_list.txt"
keep_list = "/Users/luke/Desktop/albums_to_keep.txt"

keepers = []

File.open(input_list) do |file|
  file.each do |tmp|
    begin
      album_name = tmp.chomp!.force_encoding('UTF-8')
      #if album_name =~ /^[A-Z][a-z]+, [0-9]+/
      if album_name =~ /^[A-Z][a-z]+ \d+, \d+/
        puts "- #{album_name} Generated album"
        next
      end

      keepers << [album_name, "Not matched otherwise"]
    rescue => message
      $stderr.puts "Could not handle #{album_name.inspect}: #{message}"
      next
    end
  end
end

File.open(keep_list, "w") do |file|
  keepers.sort.each do |name, reason|
    #puts "| #{name} #{reason}"
    file.puts name
  end
end
