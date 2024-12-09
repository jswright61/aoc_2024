#!/usr/bin/env ruby
require "pry"
require_relative "lib/answer"
require_relative "lib/load_files"
my_files = LoadFiles.new
@data = my_files.data
def line_data(data = @data)
  data.split("\n")
end
require_relative my_files.code_file
