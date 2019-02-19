# Paint Fill
# Implement the "paint fill" function that one might see on many image editing programs. That is, given a screen (represented by a two-dimensional array of colors), a point, and a new color, fill in the surrounding area until the color changes from the original color.

# Let's define "surrounding area"
# A point is included in the surrounding area of another point if there is a path from one point to another in which the color is the same as the source point

# So if we want to find teh surrounding area of a point
# we can run DFS from that point and include the points
# found in the search as long as there color does not change
# Then we can mark those points for update and update each
# in another step
# I think we can do better if we update as we move
# Can we do this while still allowing DFS to continue without problems?
# The issue arises when we have paths that cross
# we can either design our alg in such a way that paths don't cross
# or that if they were updated this cycle to keep them in thepath
# So I think this is mostly a performanc concern
# Let's say we allow paths to cross we'll be goig over teh array over and over many many times.
# I think we can safely say that paths won't corss BECAUSE
# let's say an path leads to a point that was already visited. Well That point must have been explored fully already (or is in teh process of being explored) so a second visit there can't turn up any new squares if the first visit is comprehensive.
# So let's say that our DFS doesn't leave any holes if we do it right


# Do diagnoal paths count?
# XOO
# OXO
# OOX
# If this is the path and we fill the top right
# Will it fill all values except for the diagonal?
# or just the 3 O's in the topright
# . Ithin we just do the top right
#   Our DFS does not run through diagonals

# We could paint at the leaves of the DFS

class PaintFill
  def initialize(screen)
    @screen = screen
  end

  def paint(point, from_color, to_color)
    return if get_color(point) != from_color
    set_color(point, to_color)
    neighbors = neighbors(point)

    neighbors.each do |neighbor_point|
      paint(neighbor_point, from_color, to_color)
    end
  end

  def call(point, to_color)
    check_point_bounds
    # If we try to paint a pixel the same color it already is we need to not try to explore out from that pixel
    from_color = get_color(point)
    if from_color != to_color
      paint(point, from_color, to_color)
    end

    print
  end

  # return all neighbors of the point in the screen
  # Array of Point Objects
  # Accounts for edge conditions of array
  # Currently, does not use diagonals
  def neighbors(point)
    results = []
    directions = [
      [1,  0],
      [0,  1],
      [-1, 0],
      [0, -1]
    ]
    directions.each do |direction|
      dir_x = direction[0]
      dir_y = direction[1]

      neighbor = Point.new(point.x + dir_x, point.y + dir_y)
      if in_bounds(neighbor)
        results << neighbor
      end
    end

    results
  end

  def get_color(point)
    return nil if !in_bounds(point)
    @screen[point.x][point.y]
  end

  def set_color(point, color)
    return nil if !in_bounds(point)
    @screen[point.x][point.y] = color
  end

  # Let's define the 2D array as rectangular (since it's representing a screen)
  # and it will ahve nil for the parts of the image that may not be rectangular
  def in_bounds(point)
    point.x >= 0 &&
    point.y >= 0 &&
    point.y < @screen.size &&
    point.x < @screen[point.y].size &&
    @screen[point.x][point.y] != nil
    # for non rectangular images
  end

  # raise error if initial point is out of bounds
  def check_point_bounds
    # raise Error.new if false
  end

  def print
    @screen.each do |row|
      puts row.join
    end
  end
end
class Point
  attr_accessor :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    "(#{x}, #{y})"
  end
end


# screen is a 2d array, not necessarily square
s1 = [
  ['X', 'O', 'O'],
  ['X', 'X', 'O'],
  ['X', 'O', 'X']
]
s2 = [
  ['X', 'O', 'O'],
  ['X', 'X', 'O'],
  ['X', 'O', 'X']
]
s3 = [
  ['X', 'O', 'O'],
  ['X', 'X', 'O'],
  ['X', 'O', 'X']
]
def deep_clone_arr(arr)
  return arr unless arr.kind_of?(Array)
  clone = []

  arr.each do |nested_val|
    val = nil
    if nested_val.kind_of?(Array)
      val = deep_clone_arr(nested_val)
    else
      val = nested_val.clone
    end
    clone << val
  end

  clone
end

s2 = deep_clone_arr(s1)
s3 = deep_clone_arr(s1)

PaintFill.new(s1).call(Point.new(0, 2), 'X')
PaintFill.new(s2).call(Point.new(2, 0), 'O')
PaintFill.new(s3).call(Point.new(2, 2), 'O')