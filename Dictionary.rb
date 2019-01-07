class Dictionary
  def initialize(words = [])
    @words = words
  end

  def word?(word)
    @words.include?(word)
  end
end