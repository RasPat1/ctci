# First Common Ancestor
# Design an algorithm and write code to find the first common ancestor of two nodes in a binary tree. Avoid storing additional nodes in a data structure. NOTE: This is not necessarily a binary search tree.
# Hints: #10, #16, #28, #36, #46, #70, #80, #96


# Q1: Do we have parent pointers?
# If we do then we can just keep parenting until there is a collistion
# But we woudl have to store all past parents in an array or something aka what it says not to do. Okay since it seems not trivial with aprent pointers let's add parent pointers

# Okay.
#### SOOOO
# We know that the root is the last common ancestor
# So how about we follow parent pointers on each of the nodes
# until both pointers are on the same side OR they are on different sides
# If they are on different sides then the root is the parent pointer
# If they are on the same side we know the child on that side is a common ancestor that is more "first" then teh root
# so we move to that ancestor and repeat
# Runtime: WEllllll
# each node must go at most h-1 steps to the left/righ tchild of the root
# on that first iteration
# Then we reduce h-1 and do it again
# so we have 2 * h comparisons for step 1
# 2 * h-1 comaprisons for step 2 etcetc down to step h
# that's C * h^2 operations
# And if our tree is balanced that's lg^2n operations right?
# Oh duh. We could also just get the depth of the nodes
# TO start with. And then use that to bring the deeper node
# to the depth of the shallower node
# and then start running the parent pointers until we get teh total depth
class FirstCommonAncestor
  # This is recursive
  def call(root, node1, node2)
    ancestor = root
    return root if node1 == root || node2 == root

    # Bring both nodes up to the level of the shallower node
    node1, node2 = raise_nodes(root, node1, node2)

    while node1 != node2 && node1 != nil && node2 != nil
      node1 = node1.parent
      node2 = node2.parent
    end

    node1 == nil || node2 == nil ? "No Ancestor" : node1
  end

  def raise_nodes(root, node1, node2)
    d1 = depth(root, node1)
    d2 = depth(root, node2)
    diff = (d1 - d2).abs

    deeper = d1 > d2 ? node1 : node2
    shallower = deeper == node1 ? node2 : node1

    diff.times do
      deeper = deeper.parent
    end

    [deeper, shallower]
  end

  def depth(root, node)
    depth = 0

    while node != root && node != nil
      depth += 1
      node = node.parent
    end

    depth
  end

  def call2(root, node1, node2)
    ancestor = root
    return root if node1 == root || node2 == root

    sentinels = [ancestor.left, ancestor.right]

    parent_1 = climb(node1, sentinels)
    parent_2 = climb(node2, sentinels)

    if parent_1 == nil || parent_2 == nil
      return "No Ancestor"
    end

    if parent_1 == parent_2
      return call(parent_1, node1, node2)
    else
      return ancestor
    end
  end

  def climb(node, sentinel_nodes)
    while !sentinel_nodes.include?(node) && node != nil
      node = node.parent
    end

    node
  end

  def call3(root, node1, node2)
    # I shouldn't need either of these if the symmetry works out
    return node1 if node1 == node2
    return root if node1 == root || node2 == root
    return false if root == nil

    in_left_subtree = call3(root.left, node1, node2)
    in_right_subtree = call3(root.right, node1, node2)

    if in_left_subtree && in_right_subtree
      return root
    elsif in_left_subtree
      return in_left_subtree
    elsif in_right_subtree
      return in_right_subtree
    end

    return false
  end
end

class Node
  attr_accessor :value, :left, :right, :parent

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
    @parent = parent
  end

  def to_s
    @value.to_s
  end
end

n1 = Node.new(1)
n2 = Node.new(2, n1)
n3 = Node.new(3)
n4 = Node.new(4)
n5 = Node.new(5, n3, n2)
n6 = Node.new(6, nil, n4)
n7 = Node.new(7, n5, n6)
n1.parent = n2
n2.parent = n5
n3.parent = n5
n4.parent = n6
n5.parent = n7
n6.parent = n7

n0 = Node.new(0)

root = n7
puts FirstCommonAncestor.new.call2(root, n1, n4)
# Doesn't work when node is not in the tree!
puts FirstCommonAncestor.new.call2(root, n1, n0)
puts FirstCommonAncestor.new.call2(root, n1, n2)
puts FirstCommonAncestor.new.call2(root, n2, n3)