#!/usr/bin/ruby
# Author: Dom Barnes
# Web: dombarnes.com
# This script will iterate through your projectDir finding all instances of .ruby-version and writing them to ruby apps.txt
# I wrote this so I know which projects need ot be updated when a new version of ruby is released.

def colorize(text, color_code)
  "\e[#{color_code}m#{text}\e[0m"
end

def red(text); colorize(text, 31); end
def green(text); colorize(text, 32); end
def normal(text); colorize(text, 1); end

searchDir = ARGV[0] || Dir.pwd
puts green("Checking #{searchDir}")
count = 0

Dir.foreach (searchDir) do |item|
	if File.directory?(item)
		next if item == '.' or item == '..' or item == '.DS_Store'
		if File.exists?(searchDir + '/' + item + '/.ruby-version')
			data = File.read(searchDir + '/' + item + '/.ruby-version')
			puts "#{normal(item)}: #{green(data)}"
			count += 1
		else
			next
		end
	else
		next
	end
end

if count == 0 
	puts "#{red("You haven't set any ruby versions")}"
end
