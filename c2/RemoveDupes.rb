require './Node.rb'

# Write code to remove duplicates from an
# unsorted linked list
# How would you solve this porblem if
# a temprary buffer is not allowed
class RemoveDupes
  def call(node)
    unique_values = {}
    prev_node = nil

    while node != nil
      if unique_values.key?(node.value)
        prev_node.next_node = node.next_node
      else
        unique_values[node.value] = true
        prev_node = node
      end

      node = node.next_node
    end
  end

  def call2(head)
    p1 = head

    while p1.next_node != nil
      p2 = p1.next_node
      p2_prev = p1

      while p2 != nil

        if p2.value == p1.value
          p2_prev.next_node = p2.next_node
        else
          p2_prev = p2
        end

        p2 = p2.next_node
      end

      p1 = p1.next_node
    end
  end
end

ll = Node.new(3)
[4,5,6,7,8,2,3,4,7].each do |val|
  ll.append_to_end(Node.new(val))
end

puts ll
RemoveDupes.new.call2(ll)
puts ll