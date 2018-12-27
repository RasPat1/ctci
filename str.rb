
# # "12" + "49" -> "61"

# # Simulate long addition
# # Allowed: we can add 2 one digit integers
# # Not Allowed: Converting the string to a decimal format and adding
# # Assume: Input must be a nonempty string representing a non-negative integer

# # Line up 2 strings with the right most digit (reverse the string)
# # Convert the target index to an integer
# # Let's add the 2 integers in the strings and add any "carry term"
# # extract the last digit from the sum and insert it into our solution string
# # save gthe carry term (which is the 2nd index of the intermediate sum)
# # Reverse the sum string at the very end!

# # Care: strings can be different length so let's right pad with 0s to make it consistent
# # Care: remove Leading 0s


# "95" + "6"

# "189" + "12" -> "201"

# "18" + "-6" => "12"

# ["8", "1"], ["6", "0"], num2_is_negative = true

# "8".to_i + ("6".to_i * -1) => ('2', 0)
# 1 + 0 = 1 => ('21', 0)

# # Result is negative
# # Both are negatvie
# # carry term negative

# "-19" + "21" => 2

# ['9', '1'] (-1)
# ['1', '2']

# -9 + 1 + 0 => -8
# # (some mod and division procedure)
# -1 + 2 + -1 => 1


# # if previous string sum is a different sign int_result * 10 + previous string
# 10 + -8 => 2

# # Each time we get a negative value convert it to a positive value and carry a negative one

def long_addition(num1, num2)
  num1_is_negative = num1.count('-') > 0
  num2_is_negative = num2.count('-') > 0

  maxLength = [num1.length, num2.length].max

  num1 = format_string(num1, maxLength)
  num2 = format_string(num2, maxLength)

  carry_term = 0
  string_sum = ""

  num1.each_with_index do |char, index|
    num1_int = num1[index].to_i
    num2_int = num2[index].to_i

    num1_int = num1_is_negative ? num1_int * -1 : num1_int
    num2_int = num2_is_negative ? num2_int * -1 : num2_int

    puts "Adding #{num1_int} + #{num2_int} + #{carry_term}"

    int_result = num1_int + num2_int + carry_term

    if int_result < 0
      int_result += 10
      carry_term = (int_result / 10) + 1
    else
      carry_term = int_result / 10
    end

    puts "int_result: #{int_result}, carry_term: #{carry_term}"
    puts "String Sum Before: #{string_sum}"
    string_sum += (int_result % 10).to_s
    puts "String Sum After: #{string_sum}"
  end
puts carry_term
  if carry_term != 0
    string_sum += carry_term.to_s

    if carry_term < 0 && string_sum.count('-') == 0
      string_sum += '-'
    end
  end

  string_sum = string_sum.reverse
end

def format_string(str, maxLength)
  str = str.gsub('-', '')
  str = str.reverse
  str = str.split('')

  # right pad
  maxLength.times do |index|
    if str[index] == nil
      str[index] = "0"
    end
  end

  return str
end


def run_test(n1, n2, expected)
  actual = long_addition(n1, n2)

  if actual == expected
    puts "Test Passed: #{n1} + #{n2}"
  else
    puts "Failed: Expected #{n1} + #{n2} = #{expected} instead was #{actual}"
  end

end

def runner
  tests = [
    ["12", "81"],
    ["189", "12"],
    ["95", "6"],
    ["189", "12"],
    ["-189", "-12"],
    ["189", "-12"],
    ["-19", "21"],
    ["19", "-21"],
    ["-19", "-21"],
    ["-12", "81"],
    ["-95", "6"],
    ["95", "-6"],
    ["-95", "-6"]
  ]

  tests.each do |test_input|
    n1 = test_input[0]
    n2 = test_input[1]
    sum = n1.to_i + n2.to_i
    run_test(n1, n2, sum.to_s)
  end
end

runner