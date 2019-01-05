require 'byebug'

# Robot Path
# Imagine a robot sitting in the upper left corner of a grid
# with r rows and c cols. The robots can only move in two directions
# right and down. Certain cells are "off limits" such that the robot
# cannot step on them. Design an algorithm to find a path for the robot
# from top left to bottom right

SQUARE_TYPES = [
  START = 'S',
  FINISH = 'F',
  EMPTY = '_',
  OFF = 'X',
  PATH = 'O',
  EXPLORED = '+'
]
# 331, 360, 388... p 344
class RobotPath
  def call(grid, x = 0, y = 0)
    # Base Case
    if end?(grid, x, y)
      grid[x][y] = FINISH
      return true
    else
      directions = [[0,1], [1,0]]
      q = []

      directions.each do |direction|
        new_x = x + direction[0]
        new_y = y + direction[1]

        if valid_move(grid, new_x, new_y)
          q << [new_x, new_y]
        end
      end

      while q.size > 0
        move_x, move_y = q.shift
        success = call(grid, move_x, move_y)
        if success
          grid[move_x][move_y] = PATH
          return true
        else
          grid[move_x][move_y] = EXPLORED
        end
      end
      return false
    end

    return false
  end

  def end?(grid, x, y)
    (x == grid.size - 1) && (y == grid[0].size - 1)
  end

  def valid_move(grid, x, y)
    grid[x] != nil && grid[x][y] == EMPTY
  end
end

class RobotPathSpec
  def initialize
  end

  def call
    RobotPath.new.call
  end
end

class TestBuilder
  attr_accessor :grid

  def initialize
    @grid = []
  end

  def call(rows, cols, off_limit_count = 0)
    rows.times do
      @grid << Array.new(cols, EMPTY)
    end

    @grid[0][0] = START

    off_limit_count.times do
      add_rand_off_limit
    end
  end

  def add_rand_off_limit
    rand_row = (rand * @grid.size).floor
    rand_col = (rand * @grid[0].size).floor

    add_off_limit(rand_row, rand_col)
  end

  def add_off_limit(row_num, col_num)
    return if start?(row_num, col_num)
    return if end?(row_num, col_num)

    @grid[row_num][col_num] = OFF
  end

  def start?(row_num, col_num)
    row_num == 0 && col_num == 0
  end

  def end?(row_num, col_num)
    row_num == @grid.size - 1 && col_num == @grid[0].size - 1
  end

  def show_grid
    output = []

    @grid.each do |row|
      output << row.join('')
    end

    output.join("\n")
  end
end

tb = TestBuilder.new
tb.call(20,60,200)
RobotPath.new.call(tb.grid)
puts tb.show_grid



# Let's start by making something that generates the grids
# Should we display them on the terminal and make it look fun!
# Yes. The answer is always yes
# Let's make the grid out of underscores and put an x on off limit blocks
# and a cricle through the path the robot takes
