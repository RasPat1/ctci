require './TreeNode.rb'
require './LL.rb'
require './LLNode.rb'
require 'byebug'

# List of Depths
# Given a binary tree, design an algorithm which creates a linked list of all the nodes at each depth (e.g., if you have a tree with depth D, you'll have D linked lists).

class Depths
# DO BFS
# add each node at depth d to the linked list corresponding to depth d
# return array of linked lists at the end
  def call(root)
    depth = {}
    result = []
    queue = [root]
    depth[root] = 0

    while queue.size > 0
      node = queue.shift
      node_depth = depth[node]

      if result[node_depth] == nil
        result[node_depth] = LL.new
      end

      ll_node = LLNode.new(node.value)
      result[node_depth].add_to_tail(ll_node)

      [node.left, node.right].each do |child_node|
        if child_node
          depth[child_node] = node_depth + 1
          queue.push(child_node)
        end
      end
    end

    result
  end
end
"""
################
        1
      2   3
    4   5
  7
################

result = [
  N(1),
  N(2) -> N(3),
  N(4) -> N(5),
  N(7)
]
result[d] = head node of the children at depth d from left ro right
"""
nodes = []
[1,2,3,4,5,7].each do |value|
  nodes << TreeNode.new(value)
end

root = nodes[0]
root.left = nodes[1]
root.right = nodes[2]
nodes[1].left = nodes[3]
nodes[1].right = nodes[4]
nodes[3].left = nodes[5]

puts root

result = Depths.new.call(root)
puts result