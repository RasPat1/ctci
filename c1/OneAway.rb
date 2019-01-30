# There are three types of edits taht can be performedon strings:
# => Insert a character
# => Remove a character
# => Replace a character
# Write a function to check if they are no more than one edit away from each other
class OneAway
  # So let's start with some heuristics
  # if the strings are more than one char away by length then its false
  # We can't add or remove more than one character for our transformation
  # If the strings are the same length then we simply need to ensure that they differ in only one character
  # If they are 1 character different in length than we simply check if the current char vs the character
  # in teh same position in teh other string. If it is the same great move to the next one
  # If it is not check the +1 spaces
  def call(s1, s2)
    return false if s1 == nil || s2 == nil
    s1, s2 = make_s1_longer(s1, s2)

    size_diff = s1.size - s2.size
    # we can make at most 1 edit
    return false if size_diff > 1

    # Rule for same size
    # We can shortcut out here if they are the same size
    if size_diff == 0
      return one_char_diff(s1, s2)
    end

    pointer1 = 0
    pointer2 = 0

    while pointer1 < s1.size || pointer2 < s2.size
      return false if pointer1 - pointer2 > 1

      if s1[pointer1] != s2[pointer2]
        pointer1 += 1
      else
        pointer1 += 1
        pointer2 += 1
      end
    end

    true
  end

  def make_s1_longer(s1, s2)
    if s2.size > s1.size
      tmp = s1
      s1 = s2
      s2 = tmp
    end

    return s1, s2
  end

  # return true if the string are different in at most one character
  # guaranteed that they are the same size
  def one_char_diff(s1, s2)
    char_diffs = 0

    s1.split('').each_with_index do |char, index|
      char_diffs += 1 if s1[index] != s2[index]
      return false if char_diffs > 1
    end

    true
  end
end


tests = [
  ['pale', 'ple', true],
  ['pales', 'pale', true],
  ['pale', 'bale', true],
  ['pale', 'bake', false],
  ['', '', true],
  [nil, nil, false],
  ['', nil, false],
  ['same_string', 'same_string', true],
  ['short', 'oh_my_god_so_long', false],
]

tests.each do |test|
  s1 = test[0]
  s2 = test[1]
  expected = test[2]

  output = OneAway.new.call(test[0], test[1])

  if output != expected
    puts "Test Failed! s1: #{s1}, s2: #{s2}, output: #{output}, expected: #{expected}"
  else
    puts "Test Passed"
  end
end