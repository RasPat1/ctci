require './Heap.rb'

class HeapSpec
  def initialize
  end

  def call
    h = Heap.new
    inserts = [0,1,2,3,4,5,6,7,8]
    inserts.each do |num|
      h.insert(num)
    end

    puts h
    h.draw
  end
end

HeapSpec.new.call