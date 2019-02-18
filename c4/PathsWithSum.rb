require './TreeNode.rb'

# Paths with Sum
# You are given a binary tree in which each node contains an integer value (which might be positive or negative). Design an algorithm to count the number of paths that sum to a given value. The path does not need to start or end at the root or a leaf, but it must go downwards (traveling only from parent nodes to child nodes).
# Hints:#6, #14, #52, #68, #77, #87, #94, #103, #108, #115

# Okay soooo
# What if at each node we cached all the possible sums that could exist if we went down that path. WE only need to count them at teh end. And if we did this and generated it for each node we could get this count in O(n) time. We'd end up using a lot of space possibly since there are many many paths and we're caching them. But since we're only caching the sum of the paths it'll be a bit less. If for each node there is a maximum of... hmmm... what's the max # of paths for each node
# IT seems that if its a downward path it can have length between 1 and depth of tree (max depth) which is 2^path length possible paths no? Okay so memory complexity here is v v bad. But since values can be positive or negative we can't do an easy criteria for filtering out paths. But there may be some other criteria. Wait wait its almsot there. hold up. Okay so we don't have to save paths that are deeper in the tree. So we can actualyl make a good imporvemnt in space. If we've calcualted leaf paths we can compare to the sum and add teh count if they apply. Then when we get teh parent's path, we can add the child paths and then throw them out. The info we caer about is being held in the parent node since we already counted the children nodes. so there will be 3 paths in parent 1 insteD of 3 paths in parent 1 and 1 path in leaf 1 and leaf2. I think we went from 2^n paths to 2^n-1 paths. this isn't much of an improvement.
# let's try this though and see how we do
# THis is looking at it bottom-up. Is this the right way to code it
# Or can we go top down?
# let's just try some recursionand see how we do
# We could also recurse down with mutliple sum values
# finding a path with sum is the same as finding a path with
# node.value - sum or finding a path of sum. Both woudl be counted
# This should be the same idea but let's go with what we started with
class PathsWithSum
  def initialize
    @count = 0
    @sum = nil
  end
  def call(node, sum)
    @sum = sum
    path_sums = find_sums(node)
    puts path_sums.join(',')
    @count
  end

  def find_sums(node)
    return [] if node == nil

    # Base Case
    result = [node.value]

    path_sums = find_sums(node.left) + find_sums(node.right)
    path_sums.each do |path_sum|
      result << path_sum + node.value
    end

    count_sums(result)

    result
  end

  def count_sums(result)
    result.each do |sum|
      @count += 1 if sum == @sum
    end
  end
end


root =
TreeNode.new(4,
  TreeNode.new(1,
    TreeNode.new(-1,
      TreeNode.new(-2,
        TreeNode.new(-3,
          TreeNode.new(-4)
        )
      )
    ),
    TreeNode.new(2)
  ),
  TreeNode.new(6,
    TreeNode.new(1),
    TreeNode.new(7,
      TreeNode.new(8)
    )
  )
)
r2 =
TreeNode.new(6,
  TreeNode.new(1),
  TreeNode.new(7,
    TreeNode.new(8)
  )
)
r3 =
TreeNode.new(-2,
  TreeNode.new(-3,
    TreeNode.new(-4)
  )
)
r4 =
TreeNode.new(10,
  TreeNode.new(-5,
    TreeNode.new(0,
      TreeNode.new(-1,
        TreeNode.new(1)
      )
    )
  )
)

puts PathsWithSum.new.call(r4, 5)