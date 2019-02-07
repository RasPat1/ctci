require './Node.rb'

# Loop Detection
# Given a circular linked list, implement an algorithm that returns the node at the beginning of the loop

class LoopDetection
  # How about we do stuff with reversing the list
  # 3-pass linear solution, constant space
  # run 2 pointers, at 1x and 2x speed until they meet
  # If they meet we know they have met inside the loop
  # If not there is no loop and just return
  # Save the number of steps it took us to get to our current position
  # then continue to run a pointer at normal speed from the meeting position
  # and reverse the nodes as we go
  # we will eventually get back to our "meeting" node
  # Count that distance this is the size of the loop
  # Then run a pointer form the start to the end of the loop and count # of steps
  # We now know the size of the loop (l)
  # steps from start to a point in the loop form one direction (d1 = k + x)
  # and steps form the loop in teh other direction (d2 = k + y)
  # and we know x + y = l
  # so d1 + d2 = 2k + x + y =>
  # (d1 + d2 - l) / 2 = k
  # iterate k spots and return
  # omg i think this is a 4-pass solution
  # let's code it up and see if we can do better
  # or if it even works
  def call(node)
    fast = node
    slow = node
    segment_1_size = 0

    while fast.next_node != nil && (fast.next_node != slow || fast == slow)
      fast = fast.next_node.next_node
      slow = slow.next_node
      segment_1_size += 1
    end

    if fast.next_node == nil
      # We made it to the end of the list there is no cycle
      return nil
    end

    # We know we have a cycle and we know
    # How long it took for us to get there


    reverser = slow.next_node
    cycle_size = 0
    prev_node = nil

    while reverser != slow
      cycle_size += 1
      next_node = reverser.next_node
      reverser.next_node = prev_node
      prev_node = reverser
      reverser = next_node
    end
    # we just reversed the cycle!
    # iterate from the beginning again

    p3 = node
    segment_2_size = 0
    while p3 != nil
      segment_2_size += 1
      p3 = p3.next_node
    end

    distance_in = (segment_2_size + segment_1_size - cycle_size) / 2

    distance_in.times do
      node = node.next_node
    end

    return node
  end

  # Get a pointer in the loop and then
  # find the start of the loop
  # we could set off a fast and slow pointer
  # then when they are in teh same locaiton
  # or next to each other declare that we are in a loop
  # then set off a new pointer from head
  # that move once for every loop the slow pointer has gone
  # through (as determined by when we return to our starting
  # point)
  # So that would be crazy slow, n^2 but O(1) time
  def call2(node)

  end

  # Hash the nodes as we traverse and return the first
  # duplciated node. O(n) runtime and O(n) space
  # This is easy but obviously not what we want
  def sub_optimal(node)
    map = {}

    while node.next_node != nil
      if map[node]
        return node
      else
        map[node] = true
        node = node.next_node
      end
    end

    return nil
  end
end
n1 = Node.list_from_array([1,2,3,4,5])
n1.append_to_end(n1)

n2 = Node.list_from_array([1,2,3,4,5,6])
n2.append_to_end(n2)

n3 = Node.list_from_array([1,2,3])
n3.append_to_end(n3)
head = Node.new(0)
head.next_node = n3

tests = [
  [n1, n1],
  [n2, n2],
  [head, n3],
  [Node.list_from_array([1,2,3,4,5]), nil]
]
tests.each do |test|
  input = test[0]
  expected = test[1]

  output = LoopDetection.new.call(input)
  if output == expected
    puts "Test Passed"
  else
    puts "Test Failed! Input: #{input}, Output: #{output}, Expected: #{expected}"
  end
end