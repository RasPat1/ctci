require './TreeNode.rb'
require 'byebug'

# BST Sequences
# A binary search tree was created by traversing through an array from left to right and inserting each element. Given a binary search tree with distinct elements, print all possible arrays that could have led to this tree.
# EXAMPLE
# Input:
# Output: {2, 1, 3}, {2, 3, 1}
# Hints: #39, #48, #66, #82

# woah
# Assume distinct elements
# Tree does not have to be balanced
# Let's arbitraily define the binary tree pattern as
# Less than or equal to goes to left. ... oh jk distinct lements. So we don't care baoutthat constraint
# Let's walk through the insertion procedure
# null tree first element in the array is the root of the tree. Always.Yay. done.
# So for each element in the tree they are enver moved. (There is no balancing) So we can hold this invariant
# Each node in its position must be the first element larger/smaller than it's parent
# A[0] corresponds to node 0 is the root
# but for the next element whatever it is is teh first element that is larger/smaller than the root
# A = [2,1,3] and [2,3,1] create the same tree
# but whatever node is to the left and to the right of the
# root, they must have come before every one of its subnodes
# but does not have a relationship with the nodes across the way?
# since those nodes are smaller then teh root they will never conlfict with the nodes on the other side
# Okay we're piecing this togethre a little bit
# grabbign some pen and paper
# Okay so if we apply 2 rules we may be able to recursively generate this
# 1) Each node occured before all of it's subchildren
# 2) Left and right subtrees have no ordering property with each other except taht they occured before the parent
# how do we convert these 2 ideas into an algorithm
# It feels recursive.
# Let's try a base case and a few simple cases
# generally, leftsubtree -> Root -> RtSubtree
# Yields
# [Root, All_possible_mixes of left and right subtree taht have the invariant hold]
# It seems easier to grapple with this mentally if we go bottom up
# siblings can be in either order
# Let's try a really basic solution and see how far we get


class BSTSequence
  def call(root)
    return [[]] if root == nil
    results = []

    left = call(root.left)
    right = call(root.right)

    left.each do |left_array|
      right.each do |right_array|
        results += all_mixes(root, left_array, right_array)
      end
    end

    results
  end

  def all_mixes(root, left, right)
    if left.size == 0 || right.size == 0
      return [[root] + left + right]
    end

    results = []
    results += all_mixes(left[0], left[1..-1], right)
    results += all_mixes(right[0], left, right[1..-1])

    results.each do |result|
      result.unshift(root)
    end

    results
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
  TreeNode.new(6)
)
r2 = TreeNode.new(6, TreeNode.new(1), TreeNode.new(7, TreeNode.new(8)))
results = BSTSequence.new.call(root)
# debugger
# puts results
results.each do |result|
  puts result.join(',')
  # puts result.map{ |node| node.value }.join(',')
end