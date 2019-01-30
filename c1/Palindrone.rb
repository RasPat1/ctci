# Given a string, write a function to check if it is a permutation of a palindrome.
# A palindrome is a work or phrase that is the same forwards and backwards.
# A permutation is a rearrangement of letters.
# The palindrome does not need to be limited to just dictionary words.
# I'm thinking the strategy here is hash all the chars
# and check if there are 0 or 1 characters w/ and odd character count
class Palindrone
  # Even size requires all even character counts
  # Odd size requires all even except for 1 character
  # Questions to start out with
  # Can we ignore whitespace
  # Can we ignore case
  # Is a null or empty string a palindrome?

  # O(N) time but O(N) space as well (kinda depending on the size of the alphabet)
  def call(str)
    return false if str == nil || str.size == 0

    str.gsub!(' ', '')
    str.downcase!

    odd_count = 0

    char_map = {}
    str.each_char do |char|
      char_map[char] = 0 unless char_map.key?(char)
      char_map[char] += 1
    end

    char_map.each do |key, value|
      odd_count += 1 if value.odd?
      return false if odd_count > 1
    end

    true
  end

  # O(NlogN) time but no additional space required
  def call2(str)
    return false if str == nil || str.size == 0

    str.gsub!(' ', '')
    str.downcase!

    str = str.split('')
    str = str.sort
    curr_char = nil
    char_count = 0
    odd_count = 0

    str.each do |char|
      # reset the count when we switch chars and tally any odds
      if char != curr_char
        # Tally odd if necessary
        odd_count += 1 if char_count.odd?

        # Reset
        char_count = 0
        curr_char = char
      end

      char_count += 1
    end

    odd_count <= 1
  end
end

tests = [
  ['Taco cat', true],
  ['asdfaa', false],
  ['', false],
  [nil, false],
  ['aaaaa', true],
  ['aaaa', true],
  ['aaaab', true],
]

tests.each do |test|
  input = test[0]
  expected = test[1]

  output = Palindrone.new.call(input)
  if output == expected
    # puts "Test Passed"
  else
    puts "Test Failed(1) input: #{input}, output: #{output}, expected: #{expected}"
  end

  output = Palindrone.new.call2(input)
  if output == expected
    # puts "Test Passed"
  else
    puts "Test Failed(2) input: #{input}, output: #{output}, expected: #{expected}"
  end
end