# String Rotation
# Assume you have a method isSubstring which checks if one word is a substring of another
# Given 2 strings, s1 and s2, write this code to check if s2
# is a rotation of s1 using only one call to isSubstring
# (e.g. "watterbottle" is a rotation of "erbottlewat")

# STOP => TOPS => OPST => PSTO => STOP
# "POTS" is it a rotation of "STOP"


# OTHER QUESTIONS TO ASK
# Is are function case sensitive?
# Do we care about whitespace?
# Will out input be well formed.
# Do we expect [a-zA-Z0-9]?
# Will it fit in memory?
# Ascii, UTF-8, or wut?!???!


# ANALYSIS
# Time complexity: O(n*n)
# Space complexity: O(n)

# IDEAS???????
# DOUBLE THE STRING

# OG String: STOP
# Search string: OPST

# Modify our original search string and double it
# NEW OG STRING: STOPSTOP
# Search string:   OPST

class BestStringRot
  def call(s1, s2)
    return false if invalid(s1) || invalid(s2) || s1.size != s2.size
    return true if s1 == s2

    doubled_str = s1 * 2
    isSubstring(doubled_str, s2)
  end

  def invalid(str)
    BestStringRot.new.invalid(str)
  end

  # Implement by others
  # LINEAR TIME (fake)
  def isSubstring(large_str, search_str)

    large_str.split('').each_with_index do |char, str_start|
      str_end = sub_start + search_str.size
      substring = large_str[str_start..str_end]
      return true if substring == search_str
    end

    false
  end
end


class StringRot
  def call(s1, s2)
    # while s1 != s2 && s1 != original_s1
    # rotate s1
    # if it is equal return true
    # at teh end return false
    return false if invalid(s1) || invalid(s2) || s1.size != s2.size
    return true if s1 == s2

    # O(n1 + n2)
    s1 = clean_string(s1)
    s2 = clean_string(s2)

    # O(n1)
    original_s1 = s1.clone
    # O(n1)
    s1 = rotate(s1)

    # n1 * O(min(n1, n2))
    while s1 != original_s1
      if s1 == s2
        return true
      end
      s1 = rotate(s1)
    end

    s1 == s2
  end

  def rotate(str)
    str[1..-1] + str[0]
  end

  def invalid(str)
    str == nil || str.empty?
  end

  def clean_string(str)
    str = str.downcase
    str = str.gsub(" ", "")
  end
end

tests = [
  ["STOP", "POTS", false],
  ["STOP", "TOPS", true],
  ["waterbottle", "erbottlewat", true],
  ["erbottlewat", "erbottlewat", true],
  ["erbottlewat", "erbottlewaast", false],
  [nil, nil, false],
  ["", "", false]
]
tests.each do |test|
  s1 = test[0]
  s2 = test[1]
  expected = test[2]
  output = StringRot.new.call(s1,s2)

  if output != expected
    puts "Test Failed: s1: #{s1}, s2: #{s2}, Expected: #{expected}, Output: #{output}"
  else
    puts "Test Passed"
  end
end