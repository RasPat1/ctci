class Hanoi
  def initialize(size)
    @s1 = []
    @s2 = []
    @s3 = []
    @size = size
    @step_counter = 0

    @size.times do |time|
      @s1 << Disk.new(@size - time)
    end

  end

  def solve(show = false, steps_per_print = 1)
    @show = show
    @steps_per_print = steps_per_print
    print_state
    move(@s1, @s2, @s3, @size)
  end

  # now we're down here
  def move(from, to, aux, disk_count)
    # base case
    if disk_count == 1 # we're only moving one disc
      disk = from.pop
      check_disk_sizes(disk, to.last)
      to.push(disk)
      print_state
      @step_counter += 1
      return
    end

    # otherwise we need to do some flippin aorund
    move(from, aux, to, disk_count - 1)
    move(from, to, aux, 1)
    move(aux, to, from, disk_count - 1)
  end

  # Lol could these names be any sillier while still
  # being accurate
  def check_disk_sizes(disk_in_motion, base_disk)
    if base_disk != nil && disk_in_motion.size > base_disk.size
      raise DiskSizeException
    end
  end

  def print_state
    if @show && (@step_counter % @steps_per_print == 0)
      puts self
    end
  end

  def to_s
    result = ""
    empty_char = ' '
    pipe_char = '|'
    disk_char = '_'
    new_line = "\n"

    # That's size + 1 for left pad, 1 char for the pipe itself, size + 1 for between pipes 1 and 2
    # Another char for pipe 2, another size + 1 between pipes 2 and 3, another pipe char for pipe 3
    # and 1/s size + 1
    width = @size * 6 + 4 + 3

    # First row is all blank
    result << empty_char * width
    pipe1_index = @size + 1
    pipe2_index = pipe1_index + (@size * 2) + 2
    pipe3_index = pipe2_index + (@size * 2) + 2
    pipe_indexes = [pipe1_index, pipe2_index, pipe3_index]
    spacers = [0, 2 * @size + 2, 4 * @size + 4, width]

    # let's leave a little bit of space at the top
    height = @size + 2
    height.times do |row|
      width.times do |col|
        result_char = empty_char


        if row == 0 || spacers.include?(col)
          result_char = empty_char
        elsif pipe_indexes.include?(col)
          result_char = pipe_char
        else
          stack = nil
          pipe_index = nil

          if col < spacers[1]
            stack = @s1
            pipe_index = pipe_indexes[0]
          elsif col < spacers[2]
            stack = @s2
            pipe_index = pipe_indexes[1]
          else
            stack = @s3
            pipe_index = pipe_indexes[2]
          end

          disk_from_bottom = height - row - 1

          distance_from_pipe = (pipe_index - col).abs
          disk = stack[disk_from_bottom]

          if disk != nil && distance_from_pipe <= disk.size
            result_char = disk_char
          end
        end


        result << result_char
      end
      result << new_line
    end

    result
  end

  class Disk
    attr_accessor :size

    def initialize(size)
      @size = size
    end
  end
end

size = 10
Hanoi.new(size).solve(true, 10)