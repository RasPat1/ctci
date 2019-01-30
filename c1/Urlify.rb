# Replace all spaces in a sring with "%20"
# Assume that the string has sufficient space at
# the end to hold the additional characters, and that
# you are given the "true" length of the string.
class Urlify
  # Linear but requires N extra space
  def call(str, true_length)
    result_str = ''
    space_char = "02%"
    space_padding = true

    str.reverse.each_char do |char|
      space_padding = false if space_padding == true && char != ' '
      next if space_padding

      result_char = char == ' ' ? space_char : char
      result_str += result_char
    end

    result_str.reverse
  end

  def call2(str, true_length)
    # I think what they want you to do is to use
    # pointers and do this string shift in place

    # initialize array of true_length
    # iterate from the end with 2 pointers
    # one pointer shows last unoccupied space
    # other is current char that we are inspecting

    last_space = str.size - 1
    current_space = str.size - 1
    still_in_padding = true

    while current_space >= 0
      current_char = str[current_space]
      still_in_padding = false if still_in_padding == true && current_char != ' '

      if current_char == ' ' && !still_in_padding
        "%20".reverse.each_char do |char|
          str[last_space] = char
          last_space -= 1
        end
      elsif !still_in_padding
        str[last_space] = current_char
        last_space -= 1
      end

      current_space -= 1
    end

    str
  end

  def call3(str, subs)
    pad_char = ' '
    # start by calculating true_length?
    occurence_map = {}
    padding = 0
    str.each_char do |char|
      if subs.key?(char)
        padding += subs[char].size - 1
      end
    end

    true_length = str.size + padding

    result = [nil] * true_length
    last_space = true_length - 1
    current_space = str.size - 1

    find_str = ' '
    replace_str = '%20'

    while current_space >= 0
      result_str = ''
      current_char = str[current_space]

      if subs.key?(current_char)
        result_str = subs[current_char]
      else
        result_str = current_char
      end

      result_str.reverse.each_char do |char|
        result[last_space] = char
        last_space -= 1
      end

      current_space -= 1
    end

    result.join
  end
end

input_str = "Mr John Smith    "
true_length = 13
expected_output = "Mr%20John%20Smith"

subs = {}
subs[' '] = '%20'
subs['_'] = '-'
subs['('] = "%6C"
subs[')'] = "%6D"

new_input = 'Mr John Smith(IV) - MD'

puts Urlify.new.call(input_str, true_length)
puts Urlify.new.call2(input_str, true_length)
puts Urlify.new.call3(new_input, subs)