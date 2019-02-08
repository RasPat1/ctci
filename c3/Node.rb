# A Basic Node we'll use to implement a stack and queue
class Node
  attr_accessor :data, :next

  def initialize(data, next_node = nil)
    @data = data
    @next = next_node
  end

  def to_s
    "#{@data} => #{@next}"
  end
end