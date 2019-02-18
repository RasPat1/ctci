require './TreeNode.rb'
require 'byebug'

# Validate BST
# Implement a function to check if a binary tree is a binary search tree.

# Okay so starting questions
# Let's presume we gett a proper bianry tree but not comlpete or full or balanced or anythign
# The only invariant we need to check is are all the nodes
# in the left subtree of each node strictly less than
# the node we are inspecitng. And vice verse.
# We can make som arbitrary determination for where nodes taht
# are equal in value go. (Let or rihgt subtree are the same prblem)

# Sooo,.,....
# We could do a inorder traversal and make sure it is sorted right?
# Would that work?
# I think yes
# imagine a soreted array that was created into a binsearch tree
# There are a lot of trees that coudl be created
# but if the inorder traversal always hits all
# left subnodes before the node in questions andthen hits the right subnode
# then they must be in sorted order
# Okay I agree with and believe this
# So let's do an inorder tranversal which take O(n) time
# And then check if the array is sorted. Which also take (n) time
# So we can do the whole thing in O(n) time while taking O(n)
# space. Since we're storing it in an array
# I guess we could actually jsut skip the array
# and check the values as we go through them
# So we could use O(1) contant time. And just hold the most recent node
#okay so we have O(1) memory and O(n) runtime. I thin mthis is th ebest we can do. We have to chekc each node to inspect its value. SAince any node of a binary search tree may have a value that is too alrge or small and therefore make the tree not a bst

# Okay ezzzz

# ELt's look at some hints and teh answer!
# Hints: #35, #57, #86, #113, #128
# hint one talks about the arbitrary ness of inorder traversal sorted lists and the decision abotu wher ethe equal nodes shoudl be. We talked abotu that at the start so we're good
# Nest hint is reiterating the bit about the BST where EVERY node on the side has to be less/greater than the node we're inspecting
# Oh interesting
# Last hint is showign a differenta pproach
# It says make sure each node is in the right range
# I thin khint 1 is basically saying
# Imagine our inorder traversal is yields a sorted list
# BUT on one part of the tree we have an equal valued noded positioned on its left
# while in another place in teh same tree it may be placed on teh right violating the rule of the tree
# So we actually can't do what we did.
# Okay good point good point

# Instead here is an alternate approach
# We have an ever narrowing range as we recursivbely travel  through the function
# and we make sure each node is in that range
# And if it is not that means that we have an invalid tree

class ValidateBST
  def initialize
    # aka some default global min
    @min_value = 10 ** 5 * -1
    @fail = false
  end
  # inorde traversal of the tree
  # while making sure it is in sorted order
  def call(root, min = nil, max = nil)
    min ||= 10 ** 5 * -1
    max ||= 10 ** 5

    # We are in a leaf no worries keep going
    return true if root == nil

    return false unless call(root.left, min, root.value)
    # let's say that all duplicates go on the left
    return false unless min <= root.value && root.value < max
    return false unless call(root.right, root.value, max)

    # update the global min. It's okay this is not cheating
    @min_value = root.value

    true
  end

end

# um let's get a tree form somewhere
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


# This is not a bst
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
# debugger
puts root # Sorted
puts ValidateBST.new.call(root)


# This is a BST
nodes = []
[1,2,3,8,5,7].each do |value|
  nodes << TreeNode.new(value)
end

root = nodes[1]
root.left = nodes[0]
root.right = nodes[2]
nodes[2].right = nodes[3]
nodes[3].left = nodes[4]
nodes[4].right = nodes[5]

puts root # Not Sorted
puts ValidateBST.new.call(root)