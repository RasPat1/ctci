# Given an NxM matrix of integers determine the maximal sum along a path
# from the top left ot the bottom right of the matrix
class MatOp
  attr_accessor :calls

  def initialize
    @calls = 0
    @memo = {}
  end

  def set(i, j, value)
    key = keyify(i,j)
    @memo[key] = value
  end

  def has?(i,j)
    key = keyify(i,j)
    @memo.key?(key)
  end

  def get(i, j)
    key = keyify(i,j)

    if @memo.key?(key)
      @memo[key]
    else
      nil
    end
  end

  def keyify(i,j)
    "#{i},#{j}"
  end

  def nil_op(a, b, method)
    if a == nil && b == nil
      0
    elsif a == nil
      b
    elsif b == nil
      a
    else
      [a, b].send(method)
    end
  end

  def nil_min(a,b)
    nil_op(a,b, :min)
  end

  def nil_max(a,b)
    nil_op(a,b, :max)
  end


  def out_of_bounds?(mat, i, j)
    i < 0 || j < 0 || i >= mat.size || j >= mat[0].size
  end

  def malformed?(mat)
    mat.size == 0 || mat[0].size == 0
  end
end

class MatSum < MatOp
  def call(mat, i = 0, j = 0)
    @calls += 1
    return nil if malformed?(mat)
    return nil if out_of_bounds?(mat, i, j)
    return get(i,j) if has?(i,j)

    bot_max = call(mat, i + 1, j)
    right_max = call(mat, i, j + 1)

    max = nil_max(bot_max, right_max)

    sum = max + mat[i][j]
    set(i, j, sum)

    return sum
  end
end

class MatMult < MatOp
  def call(mat)
    result_obj = call_impl(mat)
    result_obj.max
  end

  def call_impl(mat, i = 0, j = 0)
    @calls += 1
    return Nil_Result.new if malformed?(mat)
    return Nil_Result.new if out_of_bounds?(mat, i, j)
    return get(i,j) if has?(i,j)

    if i == mat.size - 1 && j == mat.size[0] - 1
      return Result.new(mat[i][j], mat[i][j])
    end

    bot = call_impl(mat, i + 1, j) * mat[i][j]
    right = call_impl(mat, i, j + 1) * mat[i][j]

    vals = [mat[i][j]]

    if bot.valid? && right.valid?
      vals = [bot.min, bot.max, right.min, right.max]
    elsif bot.valid?
      vals = [bot.min, bot.max]
    elsif right.valid?
      vals = [right.min, right.max]
    end

    p "Min: #{vals.min}"
    p "Max: #{vals.max}"

    result = Result.new(vals.min, vals.max)
    set(i, j, result)

    return result
  end
end

class Result
  attr_accessor :min, :max

  def initialize(min, max)
    @min = min
    @max = max
  end

  def *(value)
    @min *= value
    @max *= value

    self
  end

  def valid?
    true
  end
end

class Nil_Result < Result
  def initialize(min = 0, max = 0)
    @min = nil
    @max = nil
  end

  def *(value)
    @min = nil
    @max = nil

    self
  end

  def valid?
    false
  end
end



class MatrixGen
  def generate(n, m, max_val = 100)
    arr = []

    n.times do
      row = []
      m.times do
        row << rand_int(max_val)
      end
      arr << row
    end

    arr
  end

  def rand_int(val)
    rand(val * 2) - val
  end
end

class Util
  def self.pretty_print(mat)
    max_size = Util.max_len(mat) + 1

    mat.each do |row|
      puts row.map(&:to_s).map{|s| s.rjust(max_size)}.join(' ')
    end
  end

  def self.max_len(mat)
    max_val = -1
    min_val = 1

    mat.each do |row|
      row.each do |val|
        if val > max_val
          max_val = val
        end

        if val < min_val
          min_val = val
        end
      end
    end

    [min_val, max_val].map(&:to_s).map(&:size).max
  end
end

mat = MatrixGen.new.generate(5,5,20)
Util.pretty_print(mat)

puts MatSum.new.call(mat)
puts MatMult.new.call(mat)

test_mat = [
  [1,2,3,1],
  [4,5,6,1],
  [7,8,9,1],
  [0,0,0,1],
]

Util.pretty_print(test_mat)
puts MatSum.new.call(test_mat)

puts MatMult.new.call(test_mat)

t_mats = [
  [
    [10]
  ],
  [
    [1,2],
    [0,0]
  ],
  [
    [2,2],
    [2,2]
  ]
]
t_mats.each do |mat|
  Util.pretty_print(mat)
  obj = MatMult.new
  p obj.call(mat)
  puts "Call count: #{obj.calls}"
end