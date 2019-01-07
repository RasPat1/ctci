require './Dictionary.rb'

class WordBreak
  attr_accessor :iterations

  def initialize(dict)
    @dict = dict
    @iterations = 0
    @memo = {}
  end

  def call(str)
    str.size.times do |length|
      @iterations += 1
      if @memo[str] != nil
        return @memo[str]
      end

      substr = str[0..length]
      puts substr

      if @dict.word?(substr)
        @memo[substr] = true if substr == str
        new_substr = str[(length + 1)..-1]
        @memo[substr] = true if call(new_substr)
        return true if @memo[substr]
      end
    end

    @memo[str] = false
    false
  end
end

dict = Dictionary.new(['word', 'words', 'break', 'wordbreak', 'a'])
wb = WordBreak.new(dict)
puts wb.call("wordsabreak")
puts wb.iterations

# dict = Dictionary.new(['a', 'abcdef', 'ab', 'abc', 'b', 'bc', 'c'])
# wb = WordBreak.new(dict)
# puts wb.call("abcddddabcdsggasdf")
# wb.iterations = 0
# test_string = "aaabbaaaadaaaaabbaaaadaaaaabcdefbaaaadaaaaabbaaaadaaaaabbaaaadaaaaabbaaaadaaaaabbaaaadaaaaabbaaaadaa"
# puts wb.call(test_string*4)
# puts wb.iterations


