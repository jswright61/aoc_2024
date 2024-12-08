#!/usr/bin/env ruby
require "pry"
require "date"
require_relative "./lib/answer"
sample = false
day = nil
ARGV.each do |arg|
  if arg.downcase == "sample"
    sample = true
  end
  if arg.to_i.to_s == arg
    day = arg
  end
end
day ||= Date.today.day.to_s
day = day.rjust(2, "0")
input_file = if sample
  "samples/sample_#{day}.txt"
else
  "input/day_#{day}.txt"
end
IN_LINES = File.readlines(input_file).map {|ln| ln.strip}
puts "#{IN_LINES.count} lines imported"
SAMPLE_LINES = IN_LINES.sample(20)

require "./lib/day_#{day}.rb"
