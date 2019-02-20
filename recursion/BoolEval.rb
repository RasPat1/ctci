# Boolean Evaluation
# Given a boolean expression consisting of the symbols 0 (false), 1 (true), & (AND), | (OR), and ^ (XOR), and a desired boolean result value result, implement a function to count the number of ways of parenthesizing the expression such that it evaluates to result.
# EXAMPLE
# countEval("1^0|0|1", false) -> 2 countEval("0&0&0&1^1|0", true) -> 10
# Hints: #748, #168, #197, #305, #327

# Okay so we have binary operations aka a number of fucntions that take in exactly two inputs and return 1 output
# We have a way of reducing the expressions from an operation to a value
# We're looking for an order of evaluation that leads to the desired result
# okay so we can say that we are looking for the order of evaluation
# The parenthesization basically says which operation runs first
# In an expression with n operators we will execute n operations to fully reduce the expression
# and that can happen in n! orders
# n options for the first operator to reduce, n-1 for the second etcetc
# each expression would be 2n + 1 characters long here (just fyi trivia)
# So if we're counting the ways we could brute force.
# run thorugh every order of reducing the expression
# And then we could memoize?
# we might be able to work in reverse order as well and do a memoized DP hmmm
# For example
# 1^0|0|0|1, false means
# 1^(1) = false
# so now we're looking for the number of ways
# (0|0|0|1) can be parenthesized to  = true
# aka subproblem is
# 0|0|0|1, true
# which means next subproblem is 0|(1)
# 0|0|1, true
# next subproblem is
# 0|1, true and the answer for that is 1
# hmmmm this feels a little bit wrong
# looking at it the other way 1|(some val)
# that can be anything so we jsut want to total num of ways ot parenthesizationn that side
# I thnk it may be neater looking at the # of ways we can order the ops
# 1^0|0|0|1 => 4 ops leads to 24 orderings but some of those are synonymous if you do the first op and then the last or the lkast then the 1st. That's the same paren pattern.
# So parenthesization is not exactly the same as ordering of operation evaluation... ?? you could have a parenthesization that force evaluation of the last one before the first one. so there are actually 24 parenthesizations. Let's say it is
# we could evaluation each of the options and count. THis is the brute force way

# ohkaay let's gtry this
# For each operation we determine what the value on the left and right need to be to get our desired result
# then we cache that substring and the number of ways. We add that for each operation

class BoolEval
  def initialize
    @steps = 0
    @memo = {}
  end

  def call(expr, target)
    ways = impl(expr, target)
    # puts "Steps: #{@steps}"
    # puts "Memo Size: #{@memo.size}"
    # puts "Expr: #{expr}, Target: #{target}, Ways: #{ways}"
    ways
  end

  def impl(expr, target)
    @steps += 1
    # Base case is a truth table definition
    return 1 if expr == '1' && target == true
    return 0 if expr == '1' && target == false
    return 1 if expr == '0' && target == false
    return 0 if expr == '0' && target == true
    cached_ways = get_cache(expr, target)
    return cached_ways if cached_ways

    ways = 0

    ops = ['&', '|', '^']
    vals = ['1', '0']

    expr.size.times do |index|
      char = expr[index]
      next if vals.include?(char)

      l_expr = expr[0..(index-1)]
      r_expr = expr[(index + 1)..-1]

      l_true = impl(l_expr, true)
      l_false = impl(l_expr, false)
      r_true = impl(r_expr, true)
      r_false = impl(r_expr, false)

      all_ways = (l_true + l_false) * (r_true + r_false)
      true_ways = 0

      if char == '&'
        true_ways = l_true * r_true
      elsif char == '|'
        true_ways = l_true*r_true + l_true*r_false + l_false*r_true
      elsif char == '^'
        true_ways = l_true * r_false + l_false * r_true
      end

      ways += (target == true) ? true_ways : all_ways - true_ways
    end

    set_cache(expr, target, ways)
    ways
  end

  def all_ways(expr)
    factorial(op_count(expr.size))
  end

  def factorial(num)
    Math.gamma(num + 1).to_i
  end

  def op_count(expr_size)
    (expr_size - 1) / 2
  end

  def get_cache(expr, target)
    key = keyify(expr, target)
    @memo[key]
  end

  def set_cache(expr, target, ways)
    key = keyify(expr, target)
    @memo[key] = ways
  end

  def keyify(expr, target)
    "#{expr}_#{target}"
  end
end

# Should we parse the string into an AST
# we might not need this operation class and all this other jazz
class Operation
  # all operations are symmetric so far
  SYMBOL = [
    AND = :and,
    OR = :or,
    XOR = :xor,
  ]
  VALUE = [
    TRUE = true,
    FALSE = false
  ]

  def initialize(operator, operand1, operand2)
    @operator = str_to_symbol(operator)
    @operand1 = str_to_value(operand1)
    @operand2 = str_to_value(operand2)
  end

  # Define truth tables
  def evaluate
    case operator
    when AND
      @operand1 == TRUE && @operand2 == TRUE
    when OR
      @operand1 == TRUE || @operand2 == TRUE
    when XOR
      (@operand1 == TRUE && @operand2 == FALSE) ||
      (@operand2 == TRUE && @operand1 == FALSE)
    end
  end

  def str_to_symbol(operator)
    case operator
    when '&'
      AND
    when '|'
      OR
    when '^'
      XOR
    end
  end

  def str_to_symbol(operand)
    case operand
    when '1'
      TRUE
    when '0'
      FALSE
    end
  end
end
# countEval("1^0|0|1", false) -> 2 countEval("0&0&0&1^1|0", true) -> 10
p BoolEval.new.call("1|0", true) == 1
p BoolEval.new.call("1|0", false) == 0
p BoolEval.new.call("1|1", true) == 1
p BoolEval.new.call("1|1", false) == 0
p BoolEval.new.call("0|0", true) == 0
p BoolEval.new.call("0|0", false) == 1

p BoolEval.new.call("1&0", true) == 0
p BoolEval.new.call("1&0", false) == 1
p BoolEval.new.call("1&1", true) == 1
p BoolEval.new.call("1&1", false) == 0
p BoolEval.new.call("0&0", true) == 0
p BoolEval.new.call("0&0", false) == 1

p BoolEval.new.call("1^0", true) == 1
p BoolEval.new.call("1^0", false) == 0
p BoolEval.new.call("1^1", true) == 0
p BoolEval.new.call("1^1", false) == 1
p BoolEval.new.call("0^0", true) == 0
p BoolEval.new.call("0^0", false) == 1

p BoolEval.new.call("1|0|1", false)
p BoolEval.new.call("0|0|0", false)

p BoolEval.new.call("0&0&0", false)
p BoolEval.new.call("0&0&0", true)
p BoolEval.new.call("1&0&0", false)
p BoolEval.new.call("1&0&0", true)
p BoolEval.new.call("1&1&1", false)
p BoolEval.new.call("1&1&1", true)

p BoolEval.new.call("1^0|0|1", false)
p BoolEval.new.call("1^0|0|1", true)
p BoolEval.new.call("0&0&0&1^1|0", true)