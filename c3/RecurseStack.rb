# Implement a recursive algorithm as iterative using a stack
# Just an exercise to help conceptualization
class RecurseStack
  def initialize
  end

  def stackless(n)
    return 1 if n <= 2
    stackless(n-1) + stackless(n-2)
  end

  def call(n)
    # Let's just have a raqndom recursive algorithm
    # how about fibonacci
    result = 0

    stack = []
    stack.push(n)

    while stack.size > 0
      element = stack.pop
      if element <= 2
        # memoization would make the stack example useless
        result += 1
      else
        stack.push(element - 1)
        stack.push(element - 2)
      end
    end

    result
  end
end

0.upto(10) do |n|
  puts "Fib(#{n}): #{RecurseStack.new.call(n)}"
end