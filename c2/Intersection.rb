require './Node.rb'
# Intersetion
# Given two (singly) linked lists, determine if the two lists intersect. Return the intersecting node. Note that the intersection is defined based on reference, not value. That is, if the kth node of the first linked list is the exact same node (by reference) as the jth node of the second linked list, then they are intersecting.
#  LL1
#  |
#  V
#  1->2->3->
#  ^
#  |
#  LL2


class Intersection
  # First strategy is to hash each node
  # and then return a node if it is already in the
  # hash table aka seen twice
  # This is O(n) space and O(n) run time
  # Very readabjle and easy though
  def call(ll1, ll2)
    visited = {}

    while ll1 != nil
      visited[ll1] = true
      ll1 = ll1.next_node
    end

    while ll2 != nil
      if visited[ll2]
        return ll2
      end
      ll2 = ll2.next_node
    end

    return nil
  end

  # Alternate strategy
  # Can we do this without any extra space?
  # Ooookay what if
  # We traverse teh first list and reverse as we move along
  # THen we iterate through the second list
  # and if when we're done iterating the second list
  # we end up at the start of the first list
  # we must have passed a node that we reversed
  # aka an intersecting node
  # This will tell us if it intersects or not
  # But won't return the intersecting node
  def call2(ll1, ll2)
  end

  # A intersecting node has 2 pointers pointing to it
  # An intersecting node is the next_node of 2 different
  # nodes
  def call3(ll1, ll2)
  end

  # We have an N^2 constant space solution
  # That is iterate through first list
  # Ask if next_node in first list is in second list
  # BY iterating thorugh all of second list
  # This is woof but still a valid solution
  def call4(ll1, ll2)
    while ll1 != nil
      p2 = ll2
      while p2 != nil
        return p2 if ll1 == p2
        p2 = p2.next_node
      end
      ll1 = ll1.next_node
    end

    return nil
  end

  # We could attach a node form l1 to l2 and then
  # check l2 for cycles
  # if there is a cycle then the node in l1
  # is the intersecting node
  # This is also N^2 and more complicated
  def call5(ll1, ll2)
  end

  # If we had the size we could just keep
  # popping off the longer one until they're
  # the same size and check if it's the same
  # node
  # Okay so get the size in O(n) time then!
  def call6(ll1, ll2)
    size1, tail1 = tail_and_size(ll1)
    size2, tail2 = tail_and_size(ll2)

    return nil if tail1 != tail2

    if size2 > size1
      ll2 = advance(ll2, size2 - size1)
    elsif
      ll1 = advance(ll1, size1 - size2)
    end

    while ll1 != nil
      return ll1 if ll1 == ll2
      ll1 = ll1.next_node
      ll2 = ll2.next_node
    end

    return nil
  end

  def tail_and_size(ll)
    return 0 if ll == nil
    size = 1

    while ll.next_node != nil
      ll = ll.next_node
      size += 1
    end

    return [size, ll]
  end

  def advance(ll, steps)
    steps.times do
      ll = ll.next_node
    end

    ll
  end
end

tests = [
  [
    Node.list_from_array([3,4,5]),
    Node.list_from_array([1,2,3]),
    nil
  ],
  [
    n1 = Node.list_from_array([1,2,3]),
    Node.list_from_array([4,5,6]).tap {|n| n.append_to_end(n1) },
    n1
  ],
  [
    n1 = Node.list_from_array([1,2,3]),
    Node.list_from_array([4,5,6]).tap {|n| n.append_to_end(n1.next_node) },
    n1.next_node
  ]
]
tests.each do |test|
  ll1 = test[0]
  ll2 = test[1]
  expected = test[2]
  puts ll1
  puts ll2
  result = Intersection.new.call6(ll1, ll2)
  if result == expected
    puts 'Test Passed!'
  else
    puts "Test Failed! Result #{result} != to #{expected}"
  end
end