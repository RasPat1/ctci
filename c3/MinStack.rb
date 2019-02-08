require './Stack.rb'

# Stack Min
# How woudl you design a stack which, in addition to push and pop, has a function min which returns the minimum element?
# Q1) Does it return the value of the minimum element? Or does it also take it out of the data structure?
# If it jsut returns the value we can keep track of a global min on each push
# When we remove the min by popping maybe its a little tricker because we need to update the min
# If we pop the min we can do a search for the new min. That is inefficient but an option
# If we can do anything theeeen we can use other data structures right?
# Hmm if we had push and extract min operate in O(1) time then couldnt we just push n items on the stack and then pop min items... that woudl be sorting in O(n) time lol whcih we konw can't be done wtthout a radix sort.
# So let's assume min jsut returns teh value
# When we pop a value that happens to be the min value we need a new min. That's the onyl problem currently.
#When it says stack min does it mean liek the bottom of the stack?? No, right?
# They definititely mean the minimum minum element
# okay we coudl say when you push check if the new value is teh new min
# If it is update the min value
# If it is popped
# THEN.
# go through the whole stack and find the new minimum
# We can make this slightly more efficient by holding the index of the last min
# Then when we pop the min we do a search from there to the last index

# okaay okay okay
# got it gotchu ehre we go
# Each time a min is added add the index of that min to another stack
# That stack holds the indexes of MINS!
# its a sep min stack lol
# So at any point in the stack when a new min is pushed
# we know that there is no value smaller than that below it on the stack
# So let's save that as the place to searchup to .

# when you pop the min the last min becomes teh next min
# Okay that's actaully really cool
# There is also a potential recursive idea that works here
# We thought about it but this seemed cooler

class MinStackNode < Node
  attr_accessor :min

  def initialize(element, min)
    @min = min
    super(element)
  end

  def to_s
    "(value: #{data}, min: #{min})"
  end
end

class BestMinStack < Stack
  def min
    if @head
      @head.min
    else
      nil
    end
  end

  def construct_node(element)
    new_min = min == nil || element < min ? element : min
    MinStackNode.new(element, new_min)
  end
end

class AltMinStack
  def initialize
    # @stack = Stack.new # But use min stack nodes instead
    @stack = []
  end

  def push(element)
    new_min = min
    if new_min == nil || element < new_min
      new_min = element
    end

    node = MinStackNode.new(element, new_min)
    @stack.push(node)
  end

  def pop
    return nil if is_empty? # Usually we throw an exceptio here
    @stack.pop
  end

  def peek
    return nil if is_empty?
    @stack.last.data
  end

  def min
    return nil if is_empty?
    @stack.last.min
  end

  def is_empty?
    @stack.size == 0
  end
end

# Most space effficient right?
class MinStack
  def initialize
    @stack = Stack.new
    @min_stack = Stack.new
  end

  def push(element)
    if min == nil || element <= min
      @min_stack.push(element)
    end

    @stack.push(element)
  end

  def pop
    element = @stack.pop

    if element == min
      @min_stack.pop
    end

    element
  end

  def peek
    @stack.peek
  end

  def min
    @min_stack.peek
  end
end


# ms = MinStack.new
# ms = AltMinStack.new
ms = BestMinStack.new

[5,6,4,6,7,8,1].each do |element|
  puts "Min: #{ms.min}, Top: #{ms.peek}"
  ms.push(element)
end

while ms.peek != nil
  puts "Min: #{ms.min}, Top: #{ms.peek}"
  element = ms.pop
  puts "Popped: #{element}"
end