require './Stack.rb'

# Queue via Stacks
# Implement a MyQueue class which implements a queue using two stacks.

class MyQueue
  # We could....
  # Do a lot of inefficient things.................
  # Hmmm......
  # We could do 1 stack with a remove bottom
  # okay so inefficient thing 1
  # We transfer everyone thing from one stack to the toher to pop
  # and then keep pushing onto the other stack and so on and so forth
  # This is just silly.
  # I'm thinking of an array with a queue. You just keep it circular.
  # and the stacks are implemented liek arrays anyways lol
  # so wut
  # Let's go to hint one
  # The hint says how to remove oldest element from a stack
  # answer reverse it aka pop everyone off of it
  # Okay the second hint is basicalyl saying the idea we've been rejecting is fine
  # We do O(n) work everythign we switch form push to pop omg
  # Okay fine let's implment it
  def initialize
    @pop_stack = Stack.new
    @push_stack = Stack.new
  end

  # To add an element make sure all elements are in the push stack
  # and then add to the push stack
  def add(element)
    @push_stack.push(element)
  end

  # To remove move all the items to the pop stack
  # unless already there
  # and pop away
  def remove
    if @pop_stack.is_empty?
      transfer(@push_stack, @pop_stack)
    end

    @pop_stack.pop
  end

  def peek
    # lol
    # peeking is expensive if we have an empty pop stack
    if @pop_stack.is_empty?
      transfer(@push_stack, @pop_stack)
    end

    @pop_stack.peek
  end

  def is_empty?
    @push_stack.is_empty? && @pop_stack.is_empty?
  end

  def transfer(to, from)
    while !to.is_empty?
      element = to.pop
      from.push(element)
    end
  end
end

q = MyQueue.new
puts q.is_empty?
q.add(1)
q.add(2)
q.add(3)
q.remove
q.add(4)
q.remove
q.add(5)
puts q.is_empty?
puts "Peeking: #{q.peek}"
while !q.is_empty?
  puts q.remove # 1,2,3 :thumbs_up:
  puts "Peeking: #{q.peek}"
end

# We should write a different type of test to see if we're doing the min number of iterations