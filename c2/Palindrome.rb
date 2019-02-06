require './Node.rb'

# Implement a function to check if a linked list is a palindrome
# Strategy?
# Convert to different data type and then its easy
# Do we have a tail pointer? if so this is easy
# Is it a doubly linked list cause then it's easy
class Palindrome
  # O(1) space and O(n) runtime
  # This is the best we can do I think
  def call(node)
    return nil if node == nil
    return true if node.next_node == nil

    # Set off 2 pointers
    # one is a runner going at 2 nodes a run
    # the other is reversing the array as we go along
    # Once the runner hits the end stop reversing
    # Then send off 2 pointers one in teh original direction
    # the other in the newly reversed direction
    # and compare them on the way
    # gotta deal with the even/odd edge cases

    p1 = node
    p2 = node
    left_side = nil

    while p2.next_node != nil
      p2 = p2.next_node

      # move the current node to the reverse list of the left
      # and move the main pointer farther to the right
      right_side = p1.next_node
      p1.next_node = left_side
      left_side = p1
      p1 = right_side

      if p2.next_node != nil
        p2 = p2.next_node
        right_side = right_side.next_node
      end
    end

    while right_side != nil
      r_val = right_side.value
      l_val = left_side.value
      if r_val != l_val
        return false
      end
      right_side = right_side.next_node
      left_side = left_side.next_node
    end

    true
  end

  # Push each value onto the stack then
  # once we get past the midpoint start popping
  # Uses O(n) extra space for the stack
  # O(n) runtime
  def call2(node)
    return nil if node == nil
    return true if node.next_node == nil
    p1 = node
    p2 = node
    stack = []

    # If it's an even # of nodes (say 2)
    # We want to push exactly half the values onto the stack (say 1)
    # and compare with the remaining (last value)
    # If it's an odd number of nodes (say 3)
    # we want to push half rounded down (1)
    # or push half rounded up and throw away last one (2 then po off stack)
    # Then compare from mid_point.next_node and values in the stack
    # We can push it and then pop if we realize we're odd
    # Or we can never push it and then iterate forward one if we're odd

    while p2 != nil && p2.next_node != nil
      stack.push(p1.value)
      p1 = p1.next_node
      p2 = p2.next_node.next_node
    end

    if p2 != nil
      p1 = p1.next_node
    end

    while p1 != nil
      stack_val = stack.pop
      return false if stack_val != p1.value
      p1 = p1.next_node
    end

    true
  end

  # if the reutrn value of recur is true and
  # the outer calling node has teh same value as in the reutrn
  # node we are a palindrome
  def recur(node, size)
    return [node, true] if size == 0
    return [node.next_node, true] if size == 1

    next_node, good_so_far = recur(node.next_node, size - 2)
    return [next_node.next_node, good_so_far && node.value == next_node.value]
  end

  def call3(node, size)
    if size == 1
      return [node.next_node, true]
    end
    if size == 2
      if node.value == node.next_node.value
        return [node.next_node.next_node, true]
      else
        return [nil, false]
      end
    end

    result_node, is_palin = call3(node.next_node, size - 2)

    return [nil, false] if !is_palin
    node.next_node = result_node
    new_size = size
    return call3(node, 2)
  end
end

tests = [
  [Node.list_from_array([1,2,3,2,1]), true],
  [Node.list_from_array([1,2,3,3,1]), false],
  [Node.list_from_array([1,2,3,3,2,1]), true],
  [Node.list_from_array([1,2,3,2,2,1]), false],
  [Node.list_from_array([1,1]), true],
  [Node.list_from_array([1,2]), false],
  [Node.list_from_array([1]), true]
]

tests.each do |test|
  input = test[0]
  output = test[1]

  # result = Palindrome.new.call2(input)
  # _, result = Palindrome.new.call3(input, input.size)
  _, result = Palindrome.new.recur(input, input.size)
  if result == output
    puts "Test Passed"
  else
    puts "Test Failed! Input: #{input}"
  end
end

# node = Node.list_from_array([1,2,3,2,1])
# puts node
# puts Palindrome.new.recur(node, node.size)