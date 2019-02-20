# Stack of Boxes
# You have a stack of n boxes, with widths wi, heights hi, and depths di. The boxes cannot be rotated and can only be stacked on top of one another if each box in the stack is strictly larger than the box above it in width, height, and depth. Implement a method to compute the height of the tallest possible stack. The height of a stack is the sum of the heights of each box.
# Hints: #755, #194, #274, #260, #322, #368, #378

# Can we do brute force? Yes! ALways. How? By Brute forcing duh.
# Sort by one of the three params
# Select the box with largest wi, then select the next largest if possible
# If not possible skip it
# Find the max chain length and globally store
# THen move onto the next box as teh starting box
# This is straight brute force w/ 2^n possibilities
# A box is included in teh chain or not
# Can we cache subchains?
# If a box is part of a chain and we know the optimal
# chain size from that box then it will not change if we've
# got a larger or smaller chain before that box
# Let's go through each box
# If there are no boxes that are strictly smaller, then the height of the substack
# made form that box is h
# If there are boxes taht are strictly smaller than the height of the substack that includes those
# other boxes is the max of h1 and the max substack heights of those boxes

# OKay so what we ahve so far works and is a nsq solution
# We can do better! Here's a nlgn solution I believe
# Let's sort the boxes by height to start with
# THen work our way backwards form the end of the list
# Starting with teh smallest height
# There are no boxes that are strictly smaller than it because otherwise that box would not be at the end
# The max substack height of that box is h
# THen we move backwards and find the next heighest box
# If the smallest box is strictly smaller than the next hieghest box every chain that includes the second shortest box wil include the shortest box. Therefore we can jsut delete that shortest box and update the max height of the second
# if it's not strictly larger
# A differenct box may include eitehr one of these options
# I think this is a constant time optimization
# The 3rd smallest will look at the next 2 in teh morst case
# and each n box will look at the n-1 smaller boxes in teh worst case leading us to a nsq alg still
# but there is somethign there to being sorted in all 3 dimensions
# If you sort by each of the 3 dimensions
# If the last entry is the same for all it is the "total" smallest box and therefore will be included in every chain
# That means it is our minimum max height
# we shodul never have to look at that box again
# If we always have the same
class StackBox
  def initialize
    @steps = 0
  end

  def call(boxes)
    # Cycle through each box
    # select the one w/ max height
    max = 0
    boxes = sort_by_height(boxes)
    boxes.each do |box|
      max = [find_max_height(box, boxes, 0), max].max
    end

    p "Box Count: #{boxes.size}"
    p "Steps: #{@steps}"

    max
  end

  def find_max_height(box, boxes, start = 0)
    # @steps += 1
    return box.max_stack_height if box.max_stack_height != nil


    other_max = 0
    # This would be more efficient if we sorted and looked at a smaller box list
    start.upto(boxes.size - 1) do |index|
      @steps += 1
      other_box = boxes[index]
      if box.strictly_larger(other_box)
        if other_box.max_stack_height == nil
          find_max_height(other_box, boxes, index + 1)
        end

        other_max = [other_max, other_box.max_stack_height].max
      end
    end

    box.max_stack_height = box.height + other_max
  end

  def sort_by_height(boxes)
    sorted_boxes = []
    boxes.each do |box|
      added = false
      sorted_boxes.each_with_index do |other_box, index|
        if box.height > other_box.height
          sorted_boxes.insert(index, box)
          added = true
          break
        end
      end
      sorted_boxes << box if !added
    end

    sorted_boxes
  end
end

class Box
  attr_accessor :width, :height, :depth, :max_stack_height

  def initialize(width, height, depth)
    @width = width
    @height = height
    @depth = depth
    @max_stack_height = nil
  end

  def strictly_larger(other_box)
    @width > other_box.width &&
    @height > other_box.height &&
    @depth > other_box.depth
  end

  def to_s
    "(#{@width}, #{@height}, #{@depth})"
  end
end
b1 = [
  Box.new(2,5,4),
  Box.new(2,4,4),
  Box.new(3,3,3)
]
b2 = [
  Box.new(2,2,2),
  Box.new(3,3,3),
  Box.new(3,4,3),
  Box.new(4,5,7),
]
b3 = [
  Box.new(3, 3, 3),
  Box.new(2, 2, 2),
  Box.new(2, 10, 2),
  Box.new(1, 1, 1),
]

p StackBox.new.call(b1)
p StackBox.new.call(b2)
p StackBox.new.call(b3)