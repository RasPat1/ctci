TILES = [
  LAND = 'L',
  SEA = 'S',
]

class Island
  def initialize(map)
    @map = map
    @visited = {}
    @size = map.size
  end

  def call
    tile_count = 0

    @map.each_index do |row_index|
      @map[row_index].each_index do |col_index|
        tile = @map[row_index][col_index]
        if tile == LAND && !visited?(row_index, col_index)
          tile_count += 1
          mark_adjacent_tiles(row_index, col_index)
        end
      end
    end

    tile_count
  end

  def mark_adjacent_tiles(row_index, col_index)
    if !in_bounds?(row_index, col_index) ||
        @map[row_index][col_index] == SEA ||
        visited?(row_index, col_index)
      return false
    end

    mark_tile(row_index, col_index)

    directions = [
      [1, 0], [-1, 0],
      [0, 1], [0, -1],
      # If you want diagonally connected islands
      # [1, 1], [-1, -1],
      # [-1, 1], [1, -1],
    ]
    directions.each do |dir|
      mark_adjacent_tiles(row_index + dir[0], col_index + dir[1])
    end
  end

  def mark_tile(row_index, col_index)
    @visited[key(row_index, col_index)] = true
  end

  def visited?(row_index, col_index)
    @visited[key(row_index, col_index)] == true
  end

  def key(row_index, col_index)
    "#{row_index},#{col_index}"
  end

  def in_bounds?(row_index, col_index)
    row_index < @size && row_index >= 0 &&
    col_index < @size && col_index >= 0
  end
end

# Build an nxn grid where each tile is either land or sea
class IslandGenerator
  attr_accessor :map

  # Init a size x size grid
  def initialize(size, prob)
    @map = []
    size.times do |row_count|
      @map << []
      size.times do |col_count|
        next_tile = rand < prob ? LAND : SEA
        @map[row_count] << next_tile
      end
    end
  end

  def call
  end

  def print_map
    result = []

    @map.each do |row|
      result << row.join('')
    end

    puts result.join("\n")
  end
end

ig = IslandGenerator.new(10, 0.1)
ig.print_map
puts Island.new(ig.map).call