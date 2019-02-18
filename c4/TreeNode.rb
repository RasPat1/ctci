class TreeNode
  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  def height
    left_height = left == nil ? 0 : left.height
    right_height = right == nil ? 0 : right.height

    1 + [left_height, right_height].max
  end

  def in_order
    s = ""

    s += left.in_order if left != nil
    s += value.to_s
    s += right.in_order if right != nil

    s
  end

  def to_s
    value.to_s
    # "#{in_order}"
    # "Left: #{left}, #{value}, Right: #{right}"
  end
end