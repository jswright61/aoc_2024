require "json"
ans_1 = Answer.new(5509, descr: "Sum of mid element from valid manuals")
ans_2 = Answer.new(4407, descr: "Sum of mid element from corrected manuals")


key_must_come_after_array_h = {}
key_must_come_before_array_h = {}
manuals = []
process_rules = true
rule_pairs = []

class Ts
  # Troubleshoot

  # I put a bunch of extra junk in here to give me info and try and figure out where I was failing.
  # I ran someone else's code from their GH repo to get the right answer
  # https://github.com/ozyborg/advent-of-code
  # I exported the corrected manuals from that process to json and import them here for comparison
  @@corrected_manuals = JSON.parse(File.read("samples/day_05_corrected_manuals.json"))


  class << self
    def sorted_correctly?(kmc_b4_arr, test_num, debug = true)
      test_num = test_num.to_s
      test_num_idx = nil
      first_row = nil
      first_row_idx = nil
      kmc_b4_arr.each_with_index do |row, idx|
        test_num_idx = idx if test_num_idx.nil? && row[0] == test_num
        if first_row.nil? && row[1].include?(test_num)
          first_row = row
          first_row_idx = idx
        end
        break if !first_row.nil? && !test_num_idx.nil?
      end
      if debug
        puts "key: #{first_row[0]} (index: #{first_row_idx}) contains #{test_num} at index #{
          first_row[1].index(test_num)}: #{first_row[1]}"
        puts "test_num index: #{test_num_idx}"
      end
      if test_num_idx && first_row_idx
        {test_num:, first_row_idx:, test_num_idx:, valid: test_num_idx > first_row_idx}
      else
        puts "* " * 20, "NOT SORTED CORRECTLY", "* " * 20
        # raise StandardError.new("#{test_num} not found")
      end
    end

    def corrected_manuals
      @@corrected_manuals
    end

    def check_bad_manuals(bad_manuals, page_order)
      out_of_order = []
      bad_manuals.each_with_index do |man, idx|
        order = man[1].map {|e| page_order.index(e) }
          if order.sort != order
            out_of_order << man
            puts "man #{idx} not sorted: #{order}"
          end
      end
      out_of_order
    end
  end
end



def sort_pages(key_must_come_before_array_h, all_pages)
  # extras account for page numbers for which there's no rule defined
  extras = {}
  all_pages.each {|pg| extras[pg] = []}
  # Add the extras and convert the merged hash to an array because hash keys cannot be reordered
  combined_hash = extras.merge(key_must_come_before_array_h)
  sortable_array = combined_hash.to_a
  key_moved = true
  while key_moved
    key_moved = false
    (sortable_array.size - 1).times do |idx|
      row = sortable_array[idx]
      next_row = sortable_array[idx + 1]
      if next_row[1].include?(row[0])
        key_moved = true
        sortable_array[idx], sortable_array[idx + 1] = next_row, row
      end
    end
  end
  sortable_array.to_h
end

# def alt_sort_pages(all_pages, rule_pairs)
#   was_swapped = true
#   while was_swapped
#     was_swapped = false
#     (all_pages.size - 1).times do |idx|
#       pg1 = all_pages[idx]
#       pg2 = all_pages[idx + 1]
#       if rule_pairs.any? {|rp| [pg2, pg1]}
#         was_swapped = true
#         all_pages[idx], all_pages[idx + 1] = pg2, pg1
#       end
#     end
#   end
#   all_pages
# end




IN_LINES.each do |ln|
  if process_rules && ln.empty?
    process_rules = false
  elsif process_rules
    page_1, page_2 = ln.split("|").map(&:to_i)
    rule_pairs << [page_1, page_2]
    if key_must_come_after_array_h.key?(page_2)
      key_must_come_after_array_h[page_2] << page_1
    else
      key_must_come_after_array_h[page_2] = [page_1]
    end
    if key_must_come_before_array_h.key?(page_1)
      key_must_come_before_array_h[page_1] << page_2
    else
      key_must_come_before_array_h[page_1] = [page_2]
    end
  else
    manuals << ln.split(",").map(&:to_i)
  end
end

all_pages = []
manuals.each {|man| all_pages = all_pages | man}

good_manuals = []
bad_manuals = []
repaired_manuals = []
good_mid_page_sum = 0
bad_mid_page_sum = 0
kmcbah_sorted = sort_pages(key_must_come_before_array_h, all_pages)
page_order = kmcbah_sorted.keys.freeze
# binding.pry if !@jsw_skip_pry
# puts all_pages[0..10]
# page_order = alt_sort_pages(all_pages, rule_pairs)
# puts all_pages[0..10]
# puts page_order[0..10]

manuals.each do |man|
  manual_good = true
  man.each_with_index do |pg, idx|
    if (man[idx + 1..] & (key_must_come_after_array_h[pg] || [])).any?
      manual_good = false
      repaired_man = (page_order & man)
      bad_manuals << [man, repaired_man]
      bad_mid_page_sum += repaired_man[repaired_man.count / 2].to_i
      repaired_manuals << repaired_man
      break
    end
  end
  if manual_good
    good_manuals << man
    good_mid_page_sum += man[man.count / 2].to_i
  end
end
all_pages.sort!

binding.pry unless ans_1.check(good_mid_page_sum)
binding.pry unless ans_2.check(bad_mid_page_sum)


out_of_order = Ts.check_bad_manuals(bad_manuals, page_order)
puts "Out of order: #{out_of_order}"

bad_manuals.each_with_index do |man, idx|
  man << Ts.corrected_manuals[idx]
end

verified_mans = bad_manuals.select {|man| man[1][..-2] == man[2]}
# puts incorrect_mans

# puts "Answer 2 must be less than 4834"
# if answer_1 != 5509 || answer_2 != 4407
#   puts "Answer 2 must be 4407"
#   binding.pry if !@jsw_skip_pry
# end
