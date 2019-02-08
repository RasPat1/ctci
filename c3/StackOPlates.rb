require './Stack.rb'
require 'byebug'

# Stack of Plates
# Imagine a (literal) stack of plates. If the stack gets too high, it might topple. Therefore, in real life, we would likely start a new stack when the previous stack exceeds some threshold. Implement a data structure SetOfStacks that mimics this. SetO-fStacks should be composed of several stacks and should create a new stack once the previous one exceeds capacity. SetOfStacks. push() and SetOfStacks. pop() should behave identically to a single stack (that is, pop() should return the same values as it would if there were just a single stack).

# FOLLOW UP

# Implement a function popAt(int index)which performs a pop operation on a specific sub-stack.

# Hints:#64, #87

class StackOPlates
  # Looks like a stack of stacks!
  # Let's modify our OG stack
  # or we coudl make a meta-stack?
  # The follow up seems like we don't want to use a stack
  # but actually we could just as easily do that
  # but not amazingly performantly
  # Why don't we just have an array of stacks?
  # I really feel liek we're cheating using ruby here

  def initialize(threshold)
    @threshold = threshold
    @stacks = []
    @sizes = [] # we could modify our OG stack to include this. Probably cleaner
    @stacks.push(Stack.new)
    @sizes.push(0)
  end

  def push(element)
    if @sizes.last >= @threshold
      # start a new_stack
      @stacks.push(Stack.new)
      @sizes.push(0)
    end

    active_stack.push(element)
    @sizes[@sizes.size - 1] += 1 # Asymmetric
  end

  def pop
    raise EmptyMultiStackError if active_stack == nil

    result = active_stack.pop
    @sizes[@sizes.size - 1] -= 1

    if @sizes.last == 0
      @stacks.pop
      @sizes.pop
    end

    result
  end

  def active_stack
    @stacks.last
  end

  # If we pop the last plate off of a substack shodul we remove it? For now let's say no but this is reasonable. Consider it a follow-up
  def pop_at(index)
    return nil if index > @stacks.size || index < 0 # lol

    @stacks[index].pop
    @sizes[index] -= 1

    if @sizes[index] == 0
      # ruby cheating again lol
      @stacks.delete_at(index)
      @sizes.delete_at(index)
    end
  end

  # let's pretend we don't have direct access to the stack
  # in question
  # And that we want to pop that plate and replace it
  # with plates from the next stack
  # Or we could just pop form the very top and use
  # that to replace this one
  # Also can't we just recursive the pop_at
  # Maybe if it was slightly more efficient
  # or actually we dont' need the 2 stacks if we do that
  # this is all the same
  # just pick one and move to the next problem...
  def cool_pop_at(index)
    size = @stacks.size
    stack_from_top = size - index - 1

    s = Stack.new()
    while stack_from_top > 0
      stack = @stacks.pop
      s.push(stack)
      stack_from_top -= 1
    end

    # now the top of our new stack
    # is the one we want to pop from
    main_stack = @stacks.pop
    element = main_stack.pop
    while !s.is_empty?
      new_s = s.pop
      new_el = new_s.pop
      main_stack.push(new_el)
      @stacks.push(main_stack)
      main_stack = new_s
    end

    # For the last one we need to update the size value
    # and maybe delete the whole stack
    # we shodul reuse the code we alrady have for that

    @stacks.push(main_stack)
    @sizes[@sizes.size - 1] -= 1

    if @sizes.last == 0
      @stacks.pop
      @sizes.pop
    end

    element
  end

  def to_s
    result = []
    plate_char = '_'
    empty_char = ' '

    @threshold.times do |height|
      row = []
      @stacks.each_with_index do |stack, index|
        char = empty_char
        if @sizes[index] >= @threshold - height
          char = plate_char
        end
        row << char
      end
      result << row.join(empty_char)
    end

    result << 1.upto(@stacks.size).to_a.join(empty_char)

    result.join("\n")
  end
end

class EmptyMultiStackError < StandardError; end
def t1
  sop = StackOPlates.new(4)
  1.upto(22) do |val|
    sop.push(val)
    puts sop
  end
  puts sop
  sop.pop_at(2)
  sop.pop_at(2)
  sop.pop_at(2)
  puts sop
  # When we add a plate here we could add a new stack or! add to the only partially filled stack. That's up to us and a discussion with the interviewer probably a discussion of tradeoffs
  sop.pop_at(2)
  puts sop
  sop.pop_at(2)
  puts sop
  sop.pop_at(2)
  puts sop

  10.times do
    sop.pop
    puts sop
  end
  10.times do
    sop.pop
      puts sop
  end
  # LOOKS GOOOD!
end

def t2
  sop = StackOPlates.new(4)
  10.times do |time|
    sop.push(time)
  end

  puts sop
  sop.cool_pop_at(1)
  puts sop
end

t2