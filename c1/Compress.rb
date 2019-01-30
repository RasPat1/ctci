# Performs basic string compression using the counts of repeated characters.
# For example, the string aabccccaaa would cebonme a2b1c5a3. If the "compressed"
# string would not become smaller than the original string your method should
# return the original string. You can assume the string has only uppercase
# and lowercase characters
class Compress
  # We can go greedy here
  # Each time a character changes append the character and the count
  # Check at the end if it's shorter
  # Should be O(n) time and ~O(1)(?) space
  def call(str)
    return nil if str == nil
    return str if str.size <= 2
    result = ''
    current_char = str[0]
    char_count = 0

    str.split('').each_with_index do |char, index|
      char_count += 1

      if str[index] != str[index + 1]
        result += str[index] + char_count.to_s
        char_count = 0
      end
    end

    return str if str.size <= result.size
    result
  end

  def call2(str)
    return nil if str == nil
    return str if str.size <= 2
    result = []
    start_pos = 0
    end_pos = 0

    for i in 0..str.size do
      if str[i + 1] != str[i]
        end_pos = i
        result << str[i] + (end_pos - start_pos + 1).to_s
        start_pos = end_pos + 1
      end
    end

    result.join
  end
end

tests = [
  ['aa', 'aa'], # Don't convert if it doesnt's get smaller
  ['aaa', 'a3'], # Compress if compression is better
  ['aaaAAA', 'a3A3'], # It is case sensitive
  ['', ''],
  [nil, nil]
]

tests.each do |test|
  input = test[0]
  expected = test[1]
  output = Compress.new.call2(input)
  if expected == output
    puts "Test Passed"
  else
    puts "Input: #{input}, Expected: #{expected}, Output: #{output}"
  end
end