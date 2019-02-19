
class CoinCount
  attr_accessor :steps, :memo
  def initialize
    @memo = {}
    @steps = 0
    @coins = [25, 10, 5, 1]
  end

  # we want to grab the largest coin_value
  # Then we want to see all the valid counts of that largest coin value
  # that's 0 to amount / coin_value
  # Then we want to add up the number of ways that those subprobelms yield
  # if we get to amount 0 we "made a way" so let's count that
  # Then we want to memoize
  # the key will be based on the amount and the coin_index.
  # where do we save and check the memo at teh end of the function or right after the child call?
  def call(amount, coin_index = 0)
    ways = 0
    @steps += 1

    return 1 if amount == 0
    return 0 if amount < 0 || coin_index >= @coins.size

    cached_value = get_cache(amount, coin_index)
    return cached_value if cached_value != nil

    coin_value = @coins[coin_index]

    # Shortcut for last coin value
    if coin_value == @coins.last
      return (amount % coin_value == 0) ? 1 : 0
    end

    max_coin_count = (amount / coin_value) + 1 # include 0 coins
    max_coin_count.times do |coin_count|
      remaining = amount - coin_count * coin_value
      sub_ways = call(remaining, coin_index + 1)

      set_cache(remaining, coin_index + 1, sub_ways) if coin_index + 1 != @coins.size - 1
      ways += sub_ways
    end

    ways
  end

  def keyify(amount, coin_index)
    "#{amount}_#{coin_index}"
  end

  def get_cache(amount, coin_index)
    # key = keyify(amount, coin_index)
    @memo[coin_index] ? @memo[coin_index][amount] : nil
  end

  def set_cache(amount, coin_index, count)
    # key = keyify(amount, coin_index)
    @memo[coin_index] = {} unless @memo.key?(coin_index)
    @memo[coin_index][amount] = count
  end
end
class Coin
  def initialize
  end
end
# total_steps = 0
# 200.times do |amount|
# no cache hack
# amount: 5000, time: 1.199822
# amoutn: 500, time: 0.013

# cache hack
# amount: 10000, time: 0.85
# amount: 5000, time: 0.21
# amoutn: 500, time: 0.0025
# Both of these are behaving liek nsq

# Better version?
# amount: 10000, time: 0.61
# amount: 5000, time: 0.151
# amoutn: 500, time: 0.0015
start = Time.new
  amount = 5000
  cc = CoinCount.new
  ways = cc.call(amount)
stop = Time.new
  p "Amount: #{amount}"
  p "Ways: #{ways}"
  p "Steps: #{cc.steps}"
  p "Memo: #{cc.memo}"
  p "Time taken: #{stop - start}"
  # total_steps += cc.steps
# end
# p "TOtal Steps: #{total_steps}"
# "Amount: 199"
# "Ways: 1366"
# "Steps: 14635"

# "Amount: 199"
# "Ways: 1366"
# "Steps: 897"
# "TOtal Steps: 58520"

# puts c.memo
# c2 = Coins.new(10)
# puts c2.build_up_2(10)

# Why not jsut count all the ways and count up by coin sizes?