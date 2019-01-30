# Implement an algorithm to determine if a string has all unique characters.
# What if you cannot use additional data structures?
class Unique

  def call(str)
    return false if str == nil
    chars_hash = {}

    str.each_char do |char|
      return false if chars_hash.key?(char)
      chars_hash[char] = true
    end

    true
  end

  def call2(str)
    return false if str == nil

    str_array = str.split('')
    str_array = str_array.sort

    str_array.each_with_index do |char, index|
      next if index == str_array.size
      return false if str_array[index] == str_array[index + 1]
    end

    true
  end
end

tests = [
  ['asdf', true],
  ['aa', false],
  ['', true],
  [nil, false]
]
tests.each do |test|
  input = test[0]
  output = test[1]

  begin
    passed = Unique.new.call(input) == output
  rescue Exception => e
    puts e.inspect
  end
  begin
    passed_no_ds = Unique.new.call2(input) == output
  rescue Exception => e
    puts e.inspect
  end

  if passed && passed_no_ds
    puts "Test Passed!"
  else
    puts "Test Failed: Passed: #{passed}, Passed No Ds: #{passed_no_ds}, Expected: #{output}"
  end
end