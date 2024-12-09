ans_1 = Answer.new(564, descr: "Number of safe Records")
ans_2 = Answer.new(604, descr: "Safe records plus dampened safe recors")

def safe?(arr)
  ascending = nil
  (1...arr.count).each do |idx|
    if (arr[idx - 1] - arr[idx]) == 0 || (arr[idx - 1] - arr[idx]).abs > 3
      diff = :"diff_#{(arr[idx - 1] - arr[idx]).abs}"
      return [false, diff, idx, arr]
    end
    case ascending
    when nil
      ascending = arr[idx] > arr[idx - 1]
    when true
      if arr[idx] < arr[idx - 1]
        return [false, :not_ascending, idx, arr]
      end
    else
      if arr[idx] > arr[idx - 1]
        return [false, :not_descending, idx, arr]
      end
    end
  end
  [true, arr]
end

def try_minus_1(in_arr)
  (0..in_arr.count).each do |round|
    arr = in_arr.dup
    arr.delete_at(round)
    if safe?(arr)[0]
      return [true, in_arr, arr]
    end
  end
  [false, in_arr, []]
end

safe_recs = []
damp_recs = []
bad_recs = []

line_data.each do |line|
  ln = line.split.map(&:to_i)
  rslt = safe?(ln)
  if rslt[0]
    safe_recs << rslt
  else
    rslt = try_minus_1(ln)
    if rslt[0]
      damp_recs << rslt
    else
      bad_recs << rslt
    end
  end
end

binding.pry unless ans_1.check(safe_recs.count) # standard:disable Lint/Debugger
binding.pry unless ans_2.check(safe_recs.count + damp_recs.count) # standard:disable Lint/Debugger
