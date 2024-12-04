LINES = IN_LINES.map(&:chars)
# Prepend new line so that going up from first row (prev 0 - 1) goes to this row instead of -1 which would be the last row
# avoids having to code a special case for the first row for row zero
# LINES.unshift(Array.new(LINES[0].count) { "Z" })
LINES.unshift(Array.new(LINES[0].count) {"."})

#same principle: Avoids having to code special case for col[0]
LINES.each {|l| l.unshift(nil)}
ALL_DIRECTIONS = [:up, :down, :left, :right, :dul, :dur, :dll, :dlr].freeze


VALID_CROSS_DIRS = [:dll, :dlr, :dul, :dur].freeze

def next_coord(dir, ln_num, col_num)
  case dir
  when :up
    [ln_num - 1, col_num]
  when :down
    [ln_num + 1, col_num]
  when :left
    [ln_num, col_num - 1]
  when :right
    [ln_num, col_num + 1]
  when :dul
    # Diagonal Upper Left
    [ln_num - 1, col_num - 1]
  when :dur
    # Diagonal Upper Right
    [ln_num - 1, col_num + 1]
  when :dll
    # Diagonal Lower Left
    [ln_num + 1, col_num - 1]
  when :dlr
    # Diagonal Lower Right
    [ln_num + 1, col_num + 1]
  else
    raise ArgumentError.new("Invalid direction")
  end
end

def xmas_continues(letter, ln_num, col_num, word_dir)
  if letter == "M"
    next_coord = next_coord(word_dir, ln_num, col_num)
    if LINES.dig(*next_coord) == "A"
      xmas_continues("A", *next_coord, word_dir)
    else
      false
    end
  elsif letter == "A"
    next_coord = next_coord(word_dir, ln_num, col_num)
    if LINES.dig(*next_coord) == "S"
      true
    else
      false
    end
  else
    false
  end
end

xmas_found = 0
mas_for_x_found = []
LINES.each_with_index do |ln, line_num|
  ln.each_with_index do |ltr, letter_num|
    if ltr == "X"
      ALL_DIRECTIONS.each do |try_dir|
        next_coord = next_coord(try_dir, line_num, letter_num)
        if LINES.dig(*next_coord) == "M"
          if xmas_continues("M", *next_coord, try_dir)
            xmas_found += 1
            # puts "Found at [#{line_num}, #{letter_num}] going #{try_dir}. Total found: #{xmas_found}"
          end
        end
      end
    elsif ltr == "M"
      VALID_CROSS_DIRS.each do |try_dir|
        a_coord = next_coord(try_dir, line_num, letter_num)
        if LINES.dig(*a_coord) == "A"
          s_coord = next_coord(try_dir, *a_coord)
          if LINES.dig(*s_coord) == "S"
             prev = mas_for_x_found.select {|el| el[0] == a_coord}.dig(0,1)
             if prev
               prev << try_dir
             else
               mas_for_x_found << [a_coord, [try_dir]]
             end
          end
        end
      end
    end
  end
end

mas_for_x_found.select! {|el| el[1].count > 1}


puts "XMAS was found #{xmas_found} times"
puts "#{mas_for_x_found.count} MAS crosses were found"

if xmas_found != 2500 || mas_for_x_found.count != 1933
  binding.pry if !@jsw_skip_pry
end