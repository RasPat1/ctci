# EightQueens

# Write an algorithm to print all ways of arranging eight queens on an 8x8 chess board so that none of them share the same row, column, or diagonal. In this case, "diagonal" means all diagonals, not just the two that bisect the board.
# Hints: #308, #350, #371
# Can we do Bruteforce DFS? Yes we can but what's the complexity on that
# There are 64 squares and 8 queens
# So techincally there are 64! / (64 - 8)! possible configurations so lol
# But even a slight heuristic makes this expnentially better
# Let's say we konw that there will be 1 queen in each row (since they by definition can't be in teh same row)
# then we have 8 choices for the first row and 8 choices for the 2nd row etc
# So that's 8^8 which is better then 56^8 (rounded down) but still quite a few possibilities 8^8 < 10^8 ! 10 billion
# So let's use rule # 2 they cant be in teh same row
# So we'd have 8 options for the first queen and then 7 for the next and so on reducing the number of possibilities to
# 8! which is much better and doable on a cpu in a few seconds
# BUT why stop there. What if we use the diagonal rule as well. My only hesitation was okay we have to do work at each
# step to handle the "covered squares", and then at each removal of a queen we need to add uncover the squares and
# there is some overlap of certain squares based on other queens.
# So let's do this.
# Let's iterate through each row. In each row let's look at each slot. Let's recurse on each open slot by placing
# a queen there. Then let's update an associated 2d array holding the number of times each square is covered.
# Initially that has all the values as 0. Then when it's covered we add 1. This way removing queens becomes easy. We just
# subtract one from teh total covered count.  If we are able to place the last queen we've got a configuration
# otherwise we need to backtrack. # we can probably optimize by doing a lookforward at some point as well
# we can also cache symmetric positions but that is probably more trouble then its worth.  IT hn we can do this v v fast
# without doing caching. So let's decide not to for now

# 4x4
# XQXX
# XXXQ
# QXXX
# XXQX

# Another way of thinking about it is we need to select the "empty" diagonals
# there are 15 diagonals in each direction and 8 queens. Let's take the diagonals in one direction
# 7 of them will be empty aka have no queens on them

# also I think there's a reasonable procedure to do this without brute force
# But the brute force one seems kinda fun so let's keep going

class EightQueens
  attr_accessor :board, :board_counts, :steps
  QUEEN = 'Q'
  EMPTY = '_'
  ADD = :add
  REMOVE = :remove

  def initialize(size = 8)
    @board = []
    @board_counts = []
    @solved = false
    @size = size
    init_board(@size)
    @steps = 0
    # ooh we could also collect all the solutions
  end

  # select a row
  # Find the first empty slot that is uncovered
  # If we find an empty slot, place the queen there, update teh cover counts
  # and move to the next row first index
  # If we cannot find an empty slot go to the previous row and remove the queen
  # then continue with the next empty slot
  def call(row_num = 0)
    if row_num >= @board.size
      @solved = true
      return
    end

    @size.times do |col_num|
      @steps += 1
      if @board_counts[row_num][col_num] == 0
        update_board(row_num, col_num, ADD)
        call(row_num + 1)
        return if @solved
        update_board(row_num, col_num, REMOVE)
      end
    end

  end

  def update_board(start_row, start_col, move)
    # p @board
    new_val = QUEEN
    count_update = 1

    if move == REMOVE
      new_val = EMPTY
      count_update = -1
    end

    @board[start_row][start_col] = new_val

    directions = [
      [0, 1],[0, -1],
      [1, 0],[-1, 0],
      [1, 1],[-1, -1],
      [1, -1],[-1, 1]
    ]

    directions.each do |dir|
      row_num = start_row
      col_num = start_col
      while in_bounds(row_num, col_num)
        @board_counts[row_num][col_num] += count_update
        row_num += dir[0]
        col_num += dir[1]
      end
    end

    @board_counts[start_row][start_col] += count_update
  end

  def in_bounds(row_num, col_num)
    row_num >= 0 && row_num < @size &&
    col_num >= 0 && col_num < @size
  end

  def init_board(size)
    size.times do
      board_row = []
      board_count_row = []

      size.times do
        board_row << EMPTY
        board_count_row << 0
      end

      @board << board_row
      @board_counts << board_count_row
    end
  end
end

eq = EightQueens.new(20)
eq.call
# p eq.board
eq.board.each do |row|
  p row
end
p "Steps: #{eq.steps}"