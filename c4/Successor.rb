require './TreeNode.rb'
require 'byebug'

# Successor
# Write an algorithm to find the "next" node (i.e., in-order successor) of a given node in a binary search tree. You may assume that each node has a link to its parent.

# oh
# We have a parent link
# So the in order successor
# mean the the next one to the right
# that is a right child if it has one
# and parents parent if the parent is a left child
# and or the parents parents parent if theparent is a right child
#etcetcetc
# so the in order successor is the next node that is larger
# so we can just say parent until parent is larger than node
# or nil...
class Successor
  def call(node)
    return nil if node == nil
    # um if we have a right child we want that
    # If that right child has a left_child we want that...
    # You did this wrong...

    # Where's the symmetry
    # IF we have a right node
    # load that up
    # We're looking for the min from the right subtree
    # If we don't have a right child we want the parent
    # if we're on the left we just wnat the straight parent
    # if we're on the right we want the parent's parent's
    # right child's minimum

    # 1) Take the min of the right subtree if you have one
    # 2) If we're to the left of our parent then the parent is the successor
    # 3) If we are to the right of the parent we need to keep goign up the tree until we find a parent that has a right subtree and get the minimum of that
    # debugger if node.value == 3

    if node.right != nil
      return min(node.right)
    elsif node.right == nil
      parent = node.parent
      # We could be left or right subchild or our parent
      # Recurse until we're the left subchild

      while parent != nil && parent.value < node.value
        node = parent
        parent = node.parent
      end

      return parent
    end
  end

  # return the min of a BST by contiuously going left
  def min(node)
    min_node = node

    while min_node.left != nil
      min_node = min_node.left
    end

    min_node
  end
end

class TreeNodeWParent < TreeNode
  attr_accessor :parent

  def initialize(value, parent = nil)
    @parent = parent
    super(value)
  end
end

"""
################
        1
           2
              3
                  8
                5
                  7
################

"""
# This is a BST
nodes = []
[1,2,3,8,5,7].each do |value|
  nodes << TreeNodeWParent.new(value)
end

nodes[0].right = nodes[1]
nodes[1].right = nodes[2]
nodes[2].right = nodes[3]
nodes[3].left = nodes[4]
nodes[4].right = nodes[5]

nodes[1].parent = nodes[0]
nodes[2].parent = nodes[1]
nodes[3].parent = nodes[2]
nodes[4].parent = nodes[3]
nodes[5].parent = nodes[4]

nodes.each do |node|
  result = Successor.new.call(node)
  if result == nil
    puts 'nil'
  else
    puts result.value
  end
end