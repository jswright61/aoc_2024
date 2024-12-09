class Answer
  attr_accessor :expected, :descr
  @@num = 1
  def initialize(expected = nil, descr: nil)
    @expected = expected
    @descr = descr
    @num = @@num
    @@num += 1
  end

  def check(val, desc: nil, expected: nil)
    if !expected.nil?
      @expected = expected
    end
    if val == @expected
      print "\e[32m" # green
      puts "Answer #{@num} (#{@descr}): #{val} is correct"
      print "\e[0m" # reset
      true
    else
      print "\e[31m" # red
      puts "Answer #{@num} (#{@descr}): #{val} IS NOT CORRECT. Expected: #{@expected}"
      print "\e[0m" # reset
      false
    end
  end
end
