# Group Anagrams

# Write a method to sort an array of strings so that all the anagrams are next to each other.

# Hints: #717, #182, #263, #342

class GroupAnagram
  def call(input)
    maps = {}
    result = []

    input.each do |word|
      char_map = char_map(word)
      maps[char_map] = [] unless maps.key?(char_map)
      maps[char_map] << word
    end

    maps.each do |key, word_arr|
      result += word_arr
    end

    result
  end

  def char_map(word)
    map = {}

    word.each_char do |char|
      map[char] = 0 unless map.key?(char)
      map[char] += 1
    end

    map
  end
end
# checking if 2 strings are anagrams is our "comparison"
# Only difference here is that the transitive property applies
# The anagrams are in groups
# The naive way to do this might just be an n^2 anagram check
# We can check whther 2 words are anagrams of each other in O(len(s)) time. That is pretty inefficient. Can we do better!?!?!
# Let's look at an example


input = [
  'stop',
  'ant',
  'opts',
  'cups',
  'cheese',
  'tan',
  'pots',
  'ants',
]

p GroupAnagram.new.call(input)
# okay this wokrs buyt what's the complexity
# Also maybe be certain about that before writing it
# we run char map once for each word
# char map takes len(s) time for each word
# so that's O(n*k) where k is the length of the max word lol
# We're using O(n) extra spce with our result array. aka not in place
# maybe we coudl do this in place

# This is a correct sorting
# How about we just go thorugh the array. hash each word and if it fits into one of the hashes we already have then throw it in a bucket for words with that hash. Then print out all the words
# This looks like we count the letters of every word to get a character map. Then hash the chracter map to determine equality. Then do up to n comparisons and then put it in a bucket. and then spit out n words. This maybe isn't the worst.
# we still have to look at each character and put it in a char map. Not sure how one would get aroudn that. And then go through each word and compare it to up to n other character maps (assumig therre are no buckets already).
# Okay let's try that