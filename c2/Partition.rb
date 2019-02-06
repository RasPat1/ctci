require './Node.rb'
require './LL.rb'

# Partition
# Partition a linked list around a value x, such that all
# nodes less than x come before all nodes greater than or equal to x. If x is contained within the list,
# the values of x onle need to be right afte the elements
# less than x. The partition element x can appear
# anywhere in the "right partition"; it does not
# need to appear between the left andrright partitions

class Partition
  def call(node, partition)
    less_list = LL.new
    more_list = LL.new
    while node != nil
      if node.value < partition
        less_list.append(node)
      elsif node.value >= partition
        more_list.append(node)
      end

      next_node = node.next_node
      node.next_node = nil
      node = next_node
    end

    # In case we have no elements less than partition
    if less_list == nil
      return more_list.head
    end

    less_list.tail.next_node = more_list.head
    return less_list.head
  end

  def call2(node, partition)
    ll = LL.new

    while node != nil
      next_node = node.next_node
      node.next_node = nil

      if node.value < partition
        ll.append_to_start(node)
      else
        ll.append(node)
      end

      node = next_node
    end

    ll.head
  end
end

input = [3, 5, 8, 5, 10, 2, 1]
partition = 5
example_output = [3, 1, 2, 10, 5, 5, 8]

input = Node.list_from_array(input)
puts input

puts Partition.new.call2(input, partition)