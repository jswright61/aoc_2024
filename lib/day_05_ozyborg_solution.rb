#  from https://github.com/ozyborg/advent-of-code
require "pry"
require "json"
def input
  File.read("./input/day_05.txt")
end

def data
  parts = input.split("\n\n")

  [
    parts[0].split("\n").map { |r| r.split("|").map(&:to_i) },
    parts[1].split("\n").map { |r| r.split(",").map(&:to_i) }
  ]
end

def part_1
  rules, manuals = data
  # binding.pry if !@jsw_skip_pry

  manuals.select do |man|
    man.combination(2).all? { |combo| rules.include?(combo) }
  end.sum { |good_man| good_man[good_man.size / 2] }
end

def part_2
  rules, manuals = data

  bad_manuals = manuals.reject do |man|
    man.combination(2).all? { |combo| rules.include?(combo) }
  end
  repaired_manuals = bad_manuals.map do |bad_man|
    bad_man.permutation(2).select { |perm| rules.include?(perm) }
      .map(&:first).tally.sort_by(&:last).map(&:first).reverse
  end
  binding.pry if !@jsw_skip_pry
  repaired_manuals.sum { |sorted_man| sorted_man[sorted_man.size / 2] }
end
# binding.pry if !@jsw_skip_pry
puts "Part 1: #{part_1}"
puts "Part 2: #{part_2}"
