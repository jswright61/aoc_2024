mult_ptn = /mul\((\d{1,3}),(\d{1,3})\)/
dont_ptn = /(don't\(\).*?do\(\))/
dont_final_ptn = /don't\(\).*\z/

text = IN_LINES.map(&:strip).join("")
mults = text.scan(mult_ptn).map {|r| r.map(&:to_i)}
part_1_sum = 0
mults.each {|pair| part_1_sum += pair[0] * pair[1]}

valid_text = text.gsub(dont_ptn, "").gsub(dont_final_ptn, "")
valid_mults = valid_text.scan(mult_ptn).map {|r| r.map(&:to_i)}
valid_sum = 0
valid_mults.each {|pair| valid_sum += pair[0] * pair[1]}


# mults = IN_LINES.map {|ln| ln.scan(ptn).map {|r| r.map(&:to_i)};}

# sums = mults.map do |ln|
#   sum = 0
#   ln.each {|pair| sum += pair[0] * pair[1]}
#   sum
# end

# 168539636 part 1
# # 97529391 part 2
puts "part 1: #{part_1_sum}"
puts "part 2: #{valid_sum}"
if part_1_sum != 168539636 || valid_sum != 97529391
  binding.pry if !@jsw_skip_pry
end
