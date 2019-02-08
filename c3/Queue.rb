require './Node.rb'
require 'byebug'

# A basic queue supported via a linked list
# Elements are inserted at the tail and removed from the head
class Queue
  attr_accessor :head, :tail

  def initialize(head = nil)
    @head = head
    @tail = head

    while @tail != nil && @tail.next != nil
      @tail = @tail.next
    end
  end

  def add(element)
    node = Node.new(element)

    if is_empty?
      @tail = node
      @head = node
    else
      @tail.next = node
      @tail = node
    end

  end

  def remove
    raise EmptyQueueError if is_empty?

    element = @head.data
    @head = @head.next

    # special behavior for the last element?
    if is_empty?
      @head = nil
      @tail = nil
    end
  end

  # Show the value of the first node
  def peek
    raise EmptyQueueError if is_empty?
    @head.data
  end

  def is_empty?
    @head == nil
  end

  def to_s
    result = []
    node = @head

    while node != nil
      result << node.data
      node = node.next
    end

    result.join("=>")
  end
end

class EmptyQueueError < StandardError; end

class QueueSpec
  def call
    q = Queue.new
    q.add(1)
    q.add(2)
    puts q

    q.remove
    puts q
    q.remove
    puts q

    begin
      q.remove
    rescue EmptyQueueError => e
      puts e
    end
  end
end