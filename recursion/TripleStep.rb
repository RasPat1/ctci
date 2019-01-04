require './ResultHolder.rb'

# Triple Step
# A child is running up a staircase with n steps and can hop either
# 1 step, 2 steps, or 3 streps at a time. Implement a method to
# count how many possible ways the child can run up the stairs.

TYPES = [
  V1 = :v1,
  V2 = :v2
]
class TripleStep
  # Is there a closed formula
  # Similar to: integer pasrtition
  # Recursion, memoization
  # Think of a branchign model
  # => n branches into 3 branches containing, n-1, n-2, n-3
  # => Then those branches each have three right
  # => Brute force

  def initalize
  end

  def call(input, type)
    if type == V1
      v1(input)
    elsif type == V2
      v2(input)
    end
  end

  # def v1(input)
  #   if input < 0
  #     return 0
  #   elsif input <= 1
  #     return 1
  #   else
  #     return v1(input - 1) + v1(input - 2) + v1(input - 3)
  #   end
  # end

  def v1(input, memo = {})
    if memo.key?(input)
      return memo[input]
    else
      solution = nil

      if input < 0
        solution = 0
      elsif input <= 1
        solution = 1
      else
        solution = v1(input - 1, memo) + v1(input - 2, memo) + v1(input - 3, memo)
      end

      memo[input] = solution
      return memo[input]
    end
  end

  # Bottom up memoization
  def v2(input)
    memo = {
      1 => 1,
      2 => 2,
      3 => 4,
    }

    n = 4

    while n <= input
      memo[n] = memo[n-1], memo[n-2], memo[n-3]
      n += 1
    end

    return memo[n]
  end
end

class TripleStepSpec
  def initilize
  end

  def run_tests
    tests = [
      [1, 1],
      [2, 2],
      [3, 4],
      [4, 7],
    ]

    tests.each do |test|
      call(test[0], test[1])
    end
  end

  def call(input, expected)
    result = TripleStep.new.call(input, V1)

    if expected != result
      puts "Failed #{input}: #{result} instead of #{expected}"
    else
      puts "Test Passed: #{input}"
    end
  end
end

class TripleStepProf
  def initialize
  end

  def call(input, type)
    start = Time.now

    expected = TripleStep.new.call(input, type)
    time_taken = Time.now - start

    puts "Input: #{input}, Time Elapsed: #{time_taken * 1000}"

    [input, time_taken * 1000]
  end
end

class StepGraph
  def initialize
  end

  def call(max)
    graph = ResultHolder.new("Triple Step")
    graph.init_chart

    all_results = {
      v1: [],
      v2: [],
      # v3: [],
    }

    1.upto(max) do |input|
      all_results[:v1] << TripleStepProf.new.call(input, V1)
      all_results[:v2] << TripleStepProf.new.call(input, V2)
    end

    all_results.each do |key, value|
      graph.add_series(key, value)
    end

    graph.output_chart
  end
end

TripleStepSpec.new.run_tests
# TripleStepProf.new.call(22)
StepGraph.new.call(1500)
