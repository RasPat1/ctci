# Zero Matrix
# Write an algorithm such that if an element in an
# MxN matrix is 0, its entire row and column are set to 0.

# Input of a Matrix that is well behaved and no nsquare
# output will be that same amtrix with 0's in the row and column

class ZeroMatrix
  def call(matrix)
    # Use the first row and first column to mark whther there is a zero in
    # the corresponding row or column in the matrix
    # use 2 extra vars to determine, at the end,
    # whther to mark the first row and col as zeroes

    return nil if matrix == nil || matrix.size == 0

    zero_first_row = false
    zero_first_col = false

    # Iterate through first column to find a zero
    matrix[0].each do |value|
      if value == 0
        zero_first_row = true
        break
      end
    end

    # Iterate through first column to find a zero
    matrix.size.times do |row|
      value = matrix[row][0]
      if value == 0
        zero_first_col = true
        break
      end
    end

    # Iterate through rest of matrix
    # if we find a zero set the first val in that col and row to 0
    matrix.each_with_index do |row, row_index| # we are getting rows aka 1d arrays out
      row.each_with_index do |value, col_index| # we are gettign values!
        next if row_index == 0 || col_index == 0
        if value == 0
          matrix[row_index][0] = 0
          matrix[0][col_index] = 0
        end
      end
    end

    matrix.each_with_index do |row, row_index| # we are getting rows aka 1d arrays out
      row.each_with_index do |value, col_index| # we are gettign values!
        should_zero = matrix[row_index][0] == 0|| matrix[0][col_index] == 0
        if should_zero
          matrix[row_index][col_index] = 0
        end
      end
    end

    # zero out that first row and column if necessary
    if zero_first_row
      matrix[0].size.times do |index|
        matrix[0][index] = 0
      end
    end

    if zero_first_col
      matrix.size.times do |index|
        matrix[index][0] = 0
      end
    end

    matrix
  end

  def print(matrix)
    return if matrix == nil

    matrix.each do |row|
      puts row.join(',')
    end
  end
end


inputs = [
  [[1]],
  [
    [1,2,3],
    [1,0,2],
    [1,5,3],
    [7,9,0],
  ],
  [
    [4,2,3],
    [1,0,2],
    [6,5,3],
    [0,9,5],
  ],
  nil,
  [[]]
]

inputs.each do |input|
  ZeroMatrix.new.print(input)
  puts "================"
  result_matrix = ZeroMatrix.new.call(input)
  ZeroMatrix.new.print(result_matrix)
end