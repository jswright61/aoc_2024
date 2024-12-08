require "awesome_print"
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
    if ! expected.nil?
      @expected = expected
    end
    if val == @expected
      puts "Answer #{@num} (#{@descr}): #{val} is correct".green
      true
    else
      puts "Answer #{@num} (#{@descr}): #{val} IS NOT CORRECT. Expected: #{@expected}".red
      # puts "\e[38;2;244;128;36mOrange foreground\e[0m"
      # binding.pry if !@jsw_skip_pry
      false
    end
  end
end