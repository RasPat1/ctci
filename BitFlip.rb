class BitFlip
  def initialize
  end

  def call(bits)
    # First pass count # of ones and zeros
    one_count = 0
    zero_count = 0

    bits.each_char do |bit|
      one_count += 1 if bit == '1'
      zero_count += 1 if bit == '0'
    end

    min_flips = one_count

    ones_so_far = 0
    zeroes_so_far = 0

    bits.size.times do |index|
      ones_so_far += 1 if bits[index] == '1'
      zeroes_so_far += 1 if bits[index] == '0'
      flip_num = one_count - ones_so_far + zeroes_so_far
      min_flips = [min_flips, flip_num].min
    end

    min_flips
  end
end


tests = [
  ["01010101", 4],
  ["0000", 0],
  ["1100", 0],
  ["1111", 0],
  ["11110000001", 1],
  ["1111010000", 1],
  ["11110110000", 1],
  ["11110111000", 1],
  ["10110111000", 2],
  ["00110111000", 3],
  ["011010010", 3],
]

tests.each do |test|
  input = test[0]
  expected = test[1]

  output = BitFlip.new.call(input)
  if output != expected
    puts "Test Failed: #{input} expected #{expected} flips not #{output} flips"
  else
    puts "Test Passed"
  end
end