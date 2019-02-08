# Three in One
# Describe how you could use a single array to implement 3 stacks

# HMMM!
# 2 stacks could be easy use the start of the array and the end of the array as separate bottoms of the stack. Then add elements starting on the left for stack 1 and elements on teh right for stack 2 and then they have a combined max capacity of thesize of the array. If you grow too large we can do a table doubling type thing and copy the elements to another array
# But where is teh third stack
# I mean we could make a really inefficient 3 stack pattern in the array
# some mid point somewhere?
# I think the key here is how do we implment 3 stacks using an array where
# as long as teh total number of nodes in the 3 stacks is less than teh size of the array we do not need to resize and copy
# Wait. Duh
# Okay dropping that constraint let's start with
# i % 3 == 0 is the first stack i % 3 == 1 is the 2nd stack and i % 3 == 2 is the third stack
# So each stack can be max size 1/2 of the array
# This is the first bsic solution
# This can leave a lot of wasted space though namely at worst 2/3 of the array may sit unused
# We could also shift down elements forma stack to make space if another stack gets too large. making it memory efficient but making adding to the stack very poor performance-wise.
# Hmmmmmm
# We can't predetermine the slots in the array that correspond to which stack wihtout being space inefficient

# Stacks require a start point. But that start point can move. And the items in the stack don't necessarily ahve to be contiguos
# We could I guess use other dat strcutures to make it easier as well
# which may defeat the purpose
# Let's say we mark the index of the top of the stack for each element
# so just put them in the array and have some vars holding the top of the stack
# Then wrap each value as we add it to the array with the index of the array where the value right below it on the stack is
# This is just cheating. We can do this. And there is an array there. But there is also a Linked list idea here. And at the end of the day the system is representing all your memory as an Array anyways lol.
# With the stack the main thing is taht we don't want to move the bottom of the stack
# We'll probably hold a var with the index to the top of each stack
# If we used another array that woudl be cheating too lol. Since we'd be treating the array as a stack.
# Okay let's look at hint 1
# hint 1 says Stack just means most recently added elements are removed first. And taht there are many answers
# here's one that is lol
class Arr3Stack
  def initialize
    # cheating, lol but not really
    @max_stack_index = [0,0,0]
    @data = []
  end

  def push(stack_num, value)
    stack_max = @max_stack_index
    @data[stack_max * 3] = value
    @max_stack_index[stack_num] += 1
  end

  def pop
    # and so on and so forth
    stack_max = @max_stack_index
    value = @data[stack_max * 3]
    @data[stack_max * 3] = nil
    @max_stack_index[stack_num] -= 1

    value
  end
end

# Okay I looked at the hints
# It says the best we can do is what we came up with already
# That's just shift the stack values around if we get too large
# So let's say that each stack has a start and stop point stored
# ech intiially set to a position 1/3 of the way throguh the array
# If the top of one stack reaches the bottom of another stack
# split the remaining spaces and pad the tops of each stack
# To enlarge the last stack just wrap around from the end of array to beginning of the array
# Run time for this
# First shift will happen at 1/3n additions in teh worst case
# this requires 1/3n shifts or rather how ever many insertions we've already done
# imagine only inserting (removals are pretty cheap since a removal will never trigger a copy/resize)
# Then At worst once we've done the n shifts we may need to do another n shifts at (size - n) /3 steps. We can also at some point choose to do a table double here. If we do this we can probably get close to a linear amortized time. Hmm... Actually this may not be so bad with table doubling. But in reality .. Hmm I see. I was goign to say well let's just use 3 different arrays so we can get max space efficiency out of each one. But deep down the machine onyl ahs so many contiguos blcosk of ram right. So how does the machine implement an arbitrary number of contiguous blocks of memory.  I mean ther not all stacks so its prob a bit dif. Anyways.