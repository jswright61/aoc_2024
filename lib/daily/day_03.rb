ans_1 = Answer.new(168539636, descr: "Uncorrupted instructions")
ans_2 = Answer.new(97529391, descr: "fixed instructions")

mult_ptn = /mul\((\d{1,3}),(\d{1,3})\)/
dont_ptn = /(don't\(\).*?do\(\))/
dont_final_ptn = /don't\(\).*\z/

text = line_data.map(&:strip).join("")
mults = text.scan(mult_ptn).map { |r| r.map(&:to_i) }
part_1_sum = 0
mults.each { |pair| part_1_sum += pair[0] * pair[1] }

valid_text = text.gsub(dont_ptn, "").gsub(dont_final_ptn, "")
valid_mults = valid_text.scan(mult_ptn).map { |r| r.map(&:to_i) }
valid_sum = 0
valid_mults.each { |pair| valid_sum += pair[0] * pair[1] }

binding.pry unless ans_1.check(part_1_sum) # standard:disable Lint/Debugger
binding.pry unless ans_2.check(valid_sum) # standard:disable Lint/Debugger
