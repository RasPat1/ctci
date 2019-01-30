# Given an image represented by an NxN matrix, where each
# pixel in the image is 4 bytes, write a method to rotate
# the image by 90 degrees. Can you do this in place?
class MatrixRot
  # itearte through the elements between (0,0) and (N/2, N/2)
  # For each of these elements find the destination
  # Store the current value at the destination in a temp var and replace it with
  # element from the start
  # Repeat this 3 more times using the now replaced element as the new data
  def call(matrix)
    # What if it's not square? don't worry abotu it. Assume square
    visited = []
    matrix.size.times do
      row = []
      matrix.size.times do
        row << false
      end
      visited << row
    end

    matrix.each_with_index do |row, row_index|
      row.each_with_index do |value, col_index|
        next if visited[row_index][col_index]

        pre_rotate_value = matrix[row_index][col_index]
        4.times do
          visited[row_index][col_index] = true
          # update the row and col
          debug_string = "(#{row_index}, #{col_index}) =>"
          row_index, col_index = transform(
            row_index, col_index, matrix.size
          )
          debug_string += "(#{row_index}, #{col_index})"
          puts debug_string

          post_rotate_value = matrix[row_index][col_index]
          matrix[row_index][col_index] = pre_rotate_value
          pre_rotate_value = post_rotate_value
          puts "==============="
          print(matrix)
          puts "==============="
        end
      end
    end

    matrix
  end

  def print(matrix)
    matrix.each do |row|
      puts row.join(",")
    end
  end

  # Let's start with: What is a 90 degree rotation?
  # We'll say it's clockwise rotation
  # 1, 2 -> 2, -1
  # 2, -1 -> -1, -2
  # (x, y) -> (y, -x) -> (-x, -y) -> (-y, x) -> (x, y)
  # Swap to coordinates and make the second one negative
  # Coordinate system on our NxN matrix is not centered aroudn the origin
  # Takes in x and y coordniate as well as the size of the initial array
  def transform(x, y, size)
    # transform so center of matrix is 0,0
    # shift (what if not even)
    # n = n-1 lets say
    # 0,0 -> 0,n -> n,n -> n,0 -> 0,0
    # 1,0 -> 0,n-1 -> n-1,n -> 1,n -> 0,1
    shift = size -1
    return y, shift - x

    # shift_size = size - 1


    # x -= shift_size
    # y -= shift_size

    # # swap
    # tmp = x
    # x = y
    # y = tmp

    # # negate
    # y *= -1

    # # shift back
    # x += shift_size
    # y += shift_size

    # return x,y
  end
end

start = [
  [
    [5]
  ],
  [
    [1,2],
    [3,-4]
  ],
  [
    [1,2,3],
    [4,5,6],
    [7,8,9]
  ],
  [
    [1,2,3,4],
    [5,6,7,8],
    [9,'A','B','C'],
    ['D','E','F','G'],
  ]
]
start.each do |matrix|
  puts "===========Start============="
  MatrixRot.new.print(matrix)

  matrix = MatrixRot.new.call(matrix)

  puts "============END=============="
  MatrixRot.new.print(matrix)
end