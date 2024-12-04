class Answers
  def initialize()
    @next_num = 1
    @answers = []
  end

  def add(expected = - 1, result = nil, desc = "")
    @answers << {num: @next_num, expected: expected, result: result }
  end
end