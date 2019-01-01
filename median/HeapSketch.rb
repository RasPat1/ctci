class HeapSketch
  PAD_CHAR = ' '

  def initialize
  end

  def draw(heap)
    lines = []
    line_size = 40
    nodes_in_row = 1
    nodes_remaining_in_row = nodes_in_row
    level = 0
    num_size = 2
    line = ''

    heap.data.each do |num|
      pad_size = get_pad_size(line_size, nodes_in_row, num_size)

      if nodes_in_row == nodes_remaining_in_row
        line += PAD_CHAR * pad_size
      end

      line += num.to_s
      line += PAD_CHAR * num_size
      nodes_remaining_in_row -= 1

      if nodes_remaining_in_row == 0
        line += PAD_CHAR * (pad_size - num_size)
        nodes_in_row *= 2
        level += 1
        lines << line
        line = ''
        nodes_remaining_in_row = nodes_in_row
      end
    end

    lines.join("\n")
  end

  def get_pad_size(line_size, element_count, element_width)
    element_space = element_count * element_width
    inbetween_space = (element_count - 1) * element_width

    (line_size - element_space - inbetween_space) / 2
  end

  def obj_draw(heap)
    heap_elements = []

    heap.data.each do |num|
      heap_elements << HeapElement.new(num)
    end

    lines = []
    line = 0

    heap_elements.each do |element|
      line += ' '

    end
  end
end

# Heap Elements have the following properties
# => Value: The actual value of the element
# => Size: The number of characters that the element will occupy
# => Level: How many steps from the root of the heap the element is located
# => Node Type: The node can be a left or right child as well as the root node
# => Output Position: How far into the line the element should be displayed
class HeapElement
  attr_accessor :value, :size, :depth, :row_position, :node_type, :output_pos

  NODE_TYPE = [
    LEFT = :left,
    RIGHT = :right,
    ROOT = :root
  ]

  # Take in the array position and generate the meta info
  def initialize(value, array_position)
    @value = value
    @size = value.to_s.size

    @depth = Math.log(array_position + 1, 2).to_i
    @row_position = array_position - Math.pow(2, @depth)
    if array_position == 0
      @node_type = ROOT
    elsif array_position % 2 == 0
      @node_type = RIGHT
    else
      @node_type = LEFT
    end

    @output_pos = 0
  end

  def depth

  end

end