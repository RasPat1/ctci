require './Node.rb'
require './LL.rb'
require 'byebug'

# You have 2 numbers represented as a linked list, where each node congains a single digit. The digits are stored in reverse order, such hat the 1's digit is at the head of the list.  Write a function that adds the two numbers and returns the sum as a linked list.

# Inputs: (7->1->6) + (5->9->2) means 617 + 295
# Output: (2->1->9) aka 912

# Option 1) Convert back to number, then add, then convert back to linked list (BORING)
# Option 2) Let's add the numbers node by node
# and store the value in a new linked list

class LLAddition
  def call(l1, l2, debug = false)
    sum = LL.new
    carry = 0

    # max(l1.size, l2.size) iterations
    while l1 != nil || l2 != nil
      digit_sum = (l1 ? l1.value : 0) + (l2 ? l2.value : 0) + carry
      if digit_sum > 9
        carry = digit_sum / 10
        digit_sum %= 10
      else
        carry = 0
      end

      next_digit = Node.new(digit_sum)
      sum.append(next_digit)
      # alternatively store sum in nodes of l2 to use les space

      l1 = l1.next_node if l1 != nil
      l2 = l2.next_node if l2 != nil
    end

    if carry > 0
      sum.append(Node.new(carry))
    end

    sum.head
  end

  # Add l1 and l2 where the elements of each ll correspond to the digits
  # of a number where the first node is the leftmost digit when written
  # 500 => [5 => 0 => 0]
  def call_backwards(l1, l2, top_level = true)
    if l1 == nil && l2 == nil
      return [nil, 0]
    elsif l1 == nil
      return [Node.new(l2.value), 0]
    elsif l2 == nil
      return [Node.new(l1.value), 0]
    end

    if top_level
      size1 = l1.size
      size2 = l2.size
      if size1 > size2
        l2 = pad(l2, size1 - size2)
      elsif size2 > size1
        l1 = pad(l1, size2 - size1)
      end
    end

    result_node, carry = call_backwards(l1.next_node, l2.next_node, false)
    digit_sum = (l1 ? l1.value : 0) + (l2 ? l2.value : 0) + carry

    carry = 0
    if digit_sum > 9
      carry = digit_sum / 10
      digit_sum %= 10
    end

    new_node = Node.new(digit_sum)
    new_node.next_node = result_node

    if top_level && carry > 0
      carry_node = Node.new(carry)
      carry_node.next_node = new_node
      new_node = carry_node
    end

    return [new_node, carry]
  end

  def pad(ll, size)
    size.times do
      new_head = Node.new(0)
      new_head.next_node = ll
      ll = new_head
    end

    ll
  end
end



def as_input(num)
  nums = num.to_s.split('').map { |c| c.to_i }.to_a
  Node.list_from_array(nums)
end

def to_num(ll)
  num = ''

  while ll != nil
    num += ll.value.to_s
    ll = ll.next_node
  end

  num.to_i
end

1000.times do
  r1 = (rand * 1000).floor
  r2 = (rand * 1000).floor

  l1 = as_input(r1)
  l2 = as_input(r2)

  sum = r1 + r2

  result = LLAddition.new.call_backwards(l1, l2)
  result = to_num(result[0])
  if result != sum
    puts "Test Failed!"
    puts "Result: #{result} != #{sum} for input #{r1} + #{r2}"
    break
  end
end

num1 = [7,1,6]
num2 = [5,9,2]

l1 = Node.list_from_array(num1)
l2 = Node.list_from_array(num2)

puts l1
puts l2

puts LLAddition.new.call_backwards(l1, l2)

# puts LLAddition.new.call(
#   Node.list_from_array([2,6]),
#   Node.list_from_array([0,2,9]),
#   false
# )