require './Stack.rb'

# Sort Stack
# Write a program to sort a stack such that the smallest items are on the top. You can use an additional temporary stack, but you may not copy the elements into any other data structure (such as an array). The stack supports the following operations: push, pop, peek, and isEmpty.

class StackSort < Stack
  # we can do some operations on push or pop
  # Prob symmetric so let's say push
  # when we push we want to maintain the invariant that
  # the stack is sorted
  # so i guess the worst but pretty simple way is to
  # basically do insertion sort as we push
  # for each push pop until we find a value smaller than
  # it on the stack and a value larger than it above and
  # insert it there
  # that means insertion takes O(n) time
  # We can do some optimizations?
  # not really because we still have to pop off all items to get to the bottom even if we know we need to go to the bottom
  # maybe ther are some C optimizations
  # but let's go with this for now
  # push: O(n)
  # pop: O(1)
  # Space: O(n)
  # peek: O(1)
  # So this is O(n^sq) sorting
  # Just basically insertion sort
  # what else can we do???

  def push(element)
    aux_stack = Stack.new

    # pop everyone smaller than element onto an aux stack
    while !is_empty? && peek < element
      aux_stack.push(pop)
    end

    # push our new elemnt into the stack
    super(element)

    while !aux_stack.is_empty?
      super(aux_stack.pop)
    end
  end
end

ss = Stack.new
[3,6,4,1,48,6,1,0,-1].each do |val|
  ss.push(val)
end

sorted_array = []
while !ss.is_empty?
  sorted_array << ss.pop
end

puts sorted_array.join(',')
# checks out so far