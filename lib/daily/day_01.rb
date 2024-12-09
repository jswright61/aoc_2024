left, right, dist, sim, right_counts = [], [], [], [], []

line_data.each do |line|
  # File.readlines("input/day_01.txt").each do |line|
  ln = line.split
  left << ln[0].to_i
  right << ln[1].to_i
end

l1, r1 = left.dup, right.dup
while l1.count > 0
  dist << (l1.delete_at(l1.index(l1.min)) - r1.delete_at(r1.index(r1.min))).abs
end
ans_1 = Answer.new(1765812, descr: "Total distance between the lists")
binding.pry if !ans_1.check(dist.sum)

# left.each do |el|
#   if !(count = right_counts.select { |arr| arr[0] == el }&.dig(0, 1))
#     count = right.select { |r_num| r_num == el }.count
#     right_counts << [el, count]
#   end
#   if count > 0
#     sim << el * count
#   end
# end
left.each do |el|
  if !(count = right_counts.select { |arr| arr[0] == el }&.dig(0, 1))
    count = right.count { |r_num| r_num == el }
    right_counts << [el, count]
  end
  if count > 0
    sim << el * count
  end
end

ans_2 = Answer.new(20520794, descr: "Similarity Score")
binding.pry if !ans_2.check(sim.sum)
