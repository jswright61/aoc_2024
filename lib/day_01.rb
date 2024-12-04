#!/usr/bin/env ruby
require "pry"

left, right, dist, sim, right_counts = [], [], [], [], []
ERRORS_PRESENT = false

IN_LINES.each do |line|
# File.readlines("input/day_01.txt").each do |line|
  ln = line.split()
  left << ln[0].to_i
  right << ln[1].to_i
end

l1, r1 = left.dup, right.dup
while l1.count > 0 do
  dist << (l1.delete_at(l1.index(l1.min)) - r1.delete_at(r1.index(r1.min))).abs
end
if  dist.sum == 1765812
# 1765812 is correct
  puts "Correct: Total Distance = #{dist.sum}"
else
  puts "INCORRECT: expected: 1765812, got #{dist_sum}"
  ERRORS_PRESENT = true
end
left.each do |el|
  if !(count = right_counts.select {|arr| arr[0] == el}&.dig(0, 1))
    count = right.select {|r_num| r_num == el}.count
    right_counts << [el, count]
  end
  if count > 0
    sim << el * count
  end
end
if sim.sum == 20520794
# 20520794 is correct
  puts "Correct: Similarity = #{sim.sum}"
else
  puts "INCORRECT: expected 20520794, got #{sim.sum}"
  ERRORS_PRESENT = true
end
if ERRORS_PRESENT
  binding.pry if !@jsw_skip_pry
else
  puts "All answers are correct"
end