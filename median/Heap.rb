require './HeapSketch.rb'

class Heap
  attr_accessor :data, :size

  def initialize
    @data = []
    @size = 0
  end

  def insert(num)
    @size += 1
    @data << num
  end

  def to_s
    "Heap size: #{size}\nHeap Contents: #{@data}"
  end

  def draw
    puts HeapSketch.new.draw(self)
  end
end