require './Node.rb'

# A basic stack supported via a linked list
class Stack
  attr_accessor :head

  def initialize(head = nil)
    @head = head
  end

  def peek
    if @head
      @head.data
    else
      nil
    end
  end

  def pop
    raise EmptyStackError if is_empty?
    node = @head
    @head = @head.next

    node.data
  end

  def push(element)
    node = construct_node(element)
    node.next = @head
    @head = node
  end

  def is_empty?
    @head == nil
  end

  def construct_node(element)
    Node.new(element)
  end

  def to_s
    # print nodes in reverse order for a stack
    # and use a stack to do that lol right?
    result = []
    node = @head
    while node != nil
      result << node.data
      node = node.next
    end

    result.reverse.join("=>")
  end
end

class EmptyStackError < StandardError; end

class StackSpec
  def call
    s = Stack.new
    s.push(1)
    s.push(2)
    s.push(3)

    puts s
    puts s.is_empty?
    puts s.peek
    puts s.pop
    puts s
    puts s.pop
    puts s.pop
    puts s
    puts s.is_empty?

    begin
      puts s.pop
    rescue EmptyStackError => e
      puts e
    end
  end
end