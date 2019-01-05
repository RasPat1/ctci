# Recursive multiply
# Write a function to multiply 2 positive integers  wihtout using the * operator.
# You cause addition, subtraction and bit shifting, but you shoudl minimize the number of those operations

# Brute force double is to do a double loop
# Better version is to make one of them even in log 2 and bit shift
# So 27 * 34 can becomes 27 * 32 + 27 * 2 and then its 27 bit shift 5 times plus 27 bit shift 1 time
# Let's start with the brute force
# Hints: 166, 203, 227, 234, 246, 280, p350
class MultiCurse
  def call(a,b)
    result = 0
    operations = 0
    is_neg = false
    orig_a = a
    orig_b = b

    if a < 0 && b < 0
      a *= -1
      b *= -1
      operations += 2
    elsif a < 0 || b < 0
      a = a.abs
      b = b.abs
      operations += 2
      is_neg = true
    end

    a.times do
      result += b
      operations += 1
    end

    if is_neg
      result *= -1
    end

    cheating_check(orig_a,orig_b,result)
    [result, operations]
  end

  def call_min(a, b)
    result = 0
    operations = 0
    is_neg = false
    orig_a = a
    orig_b = b


    if a < 0 && b < 0
      a *= -1
      b *= -1
      operations += 2
    elsif a < 0 || b < 0
      a = a.abs
      b = b.abs
      operations += 2
      is_neg = true
    end

    min = [a,b].min
    max = [a,b].max

    min.times do
      result += max
      operations += 1
    end

    if is_neg
      result *= -1
    end

    cheating_check(orig_a, orig_b, result)
    [result, operations]
  end

  # We could make this recursive as well
  def shifty_call(a,b)
    result = 0
    operations = 0
    # Find the nearest power of 2 to either a or b
    # Add (or subtract but we'll get to that later) until we get there

    max, min, is_neg = shift_wrap(a,b)

    multiple = 1
    remainder = 0

    while min > multiple
      if min % 2 == 1
        remainder += max
        min -= 1
        operations += 2
      end

      max = max << 1
      multiple * 2
      min = min >> 1
      operations += 3
    end

    if min == 0
      result = max
    end

    min.times do
      result += max
      operations += 1
    end

    result += remainder
    operations += 1
    result *= -1 if is_neg
    operations += 1

    cheating_check(a, b, result)
    [result, operations]
  end

  def shift_wrap(a,b)
    return [0,0] if a == 0 || b == 0 # Cause why not!

    if (a < 0 || b < 0) && !(a < 0 && b < 0)
      is_neg = true
    else
      is_neg = false
    end
    a = a.abs
    b = b.abs

    if a < b
      c = b
      b = a
      a = c
    end
    [a, b, is_neg]
  end

  # a and b guaranteed to be positive and a is equal or larger than b
  def shift_impl(a, b, remainder, is_neg = false)
    # Define some rules here
    # determine which operand is closer to a power of 2
    # Then buff it till it is a power of two and store that value in the remainder
    # The do successive bit shifts

    a, b, is_neg = shift_wrap(a,b)
    ops = 0

    a_dist, a_ops = iterations_away(a)
    b_dist, b_ops = iterations_away(b)
    ops += a_ops
    ops += b_ops

    down_shifter, up_shifter, dist
    is a_dist < b_dist
      down_shifter = a
      up_shifter = b
      dist = a_dist
    else
      up_shifter = a
      down_shifter = b
      dist = b_dist
    end

    remainder = dist * up_shifter * -1 # this can cause some errors with our is_neg behavior
    down_shifter += dist
    while down_shifter != 0
      up_shifter << 1
      down_shifter >> 1
      operations += 2
    end


  end

  def interations_away(num)
    diff = 0
    ops = 0
    p2 = 1

    while p2 < num
      diff = num - p2
      p2 = p2 << 1
      ops += 1
    end

    # we can compare the smaller and larger values here if we want later
    diff, ops
  end


  def rec_call(a,b,remainder=0)
    if a % 2 == 1
      remainder += b
      a -= 1
    end

    if a >= 1
      a = a << 1
      b = b >> 1
    end


  end

  def cheating_check(a, b, result)
    if a * b != result
      puts "FAILED! #{a} * #{b} is #{a * b} not #{result}"
      raise Exception.new
    end
  end
end

def rand_pair
  range = 1000
  [rand_in_range(range),rand_in_range(range)]
end

def rand_in_range(range)
  rand(range * 2) # - range
end

solutions = [
  :call,
  :call_min,
  :shifty_call
]

tests = [
  [27, 34],
  [34, 27],
  [2, 2],
  [100, 100]
]

10.times do
  tests << rand_pair
end

solutions.each do |solution|
  total_ops = 0
  tests.each do |test|
    result, operations = MultiCurse.new.send(solution, *test)
    puts "Result: #{result}, Operations: #{operations}"
    total_ops += operations
  end
  puts "method #{solution.to_s} => Operations: #{total_ops}"
end



