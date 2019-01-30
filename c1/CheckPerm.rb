# Check if 2 string are permutations of each other
class CheckPerm
  def call(str1, str2)
    return false if str1 == nil || str2 == nil
    return false unless str1.size == str2.size
    # need to be the same size
    char_map = {}
    str1.each_char do |char|
      if char_map.key?(char)
        char_map[char] = char_map[char] + 1
      else
        char_map[char] = 1
      end
    end

    str2.each_char do |char|
      if char_map[char] == nil || char_map[char] == 0
        return false
      else
        char_map[char] -= 1
      end
    end

    true
  end
end

str1 = 'asdf'
str2 = 'dasf'
str3 = 'aaaa'

puts CheckPerm.new.call(str1, str2)
puts CheckPerm.new.call(str2, str3)
puts CheckPerm.new.call(str2, '')
puts CheckPerm.new.call(str2, nil)