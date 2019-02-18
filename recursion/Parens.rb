# Implement an algorithm to print all valid (e.g., properly opened and closed) combinations of n pairs of parentheses.

# Input: 3
# Output: ((())), (()()), (())(), ()(()), ()()()
# Hints: #138, #174, #787, #209, #243, #265, #295

class Parens
  def call(input)
    results = []
    paren_impl(input, [], results, 0)
    "#{results}"
  end

  def paren_impl(input, prefix, results, open_count)
    # How to create all 2 paren things from 1 paren
    # wrap it or put one next to it
    # we can add a set of closed parenthesis anywhere in the apren string
    # we can also wrap the whole thing in parens
    # Maybe we're thignin g about this wrong
    # THis is reversed balanced parenthesis
    # if the size is n
    # we know index 0 must be an open paren
    # then index 1 may be an open or closed paren
    # so now we have 2 leaves
    # in those leaves we may add an open in either and we may add a closed in the set w/ 2 open sets
    # I think we do a power set iteration and skip impossible situations with unbalanced aprenthesis
    return if prefix.size > input * 2
    return if open_count < 0 # error of some type

    if prefix.size == input * 2 && open_count == 0
      results << prefix.join
      return
    end

    if open_count < input
      paren_impl(
        input, prefix.clone << '(', results, open_count + 1
      )
    end

    if open_count > 0
      paren_impl(
        input, prefix.clone << ')', results, open_count - 1
      )
    end
  end
end

input = 3
output = ["((()))", "(()())", "(())()", "()(())", "()()()"]
result = Parens.new.call(input)
puts result