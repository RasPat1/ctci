
# Random Node
# You are implementing a binary tree class from scratch which, in addition to insert, find, and delete, has a method getRandomNode() which returns a random node from the tree. All nodes should be equally likely to be chosen. Design and implement an algorithm for getRandomNode, and explain how you would implement the rest of the methods.
# Hints: #42, #54, #62, #75, #89, #99, #112, #119

# okay hmm fun!
# So we have a binary tree which is not necessarily balanced
# or full or complete or whatever
# Let's start by defining random. We'll say that we want a unform random probabilty distribution over all of the nodes in the tree
# So each node has a 1/|tree| probability of being selected
# I mean the first thing that comes to mind is using
# an laternate dat structure right
# One that either holds the values that we can shuffle or select
# a random integer key that is in the tree
# Well let's look at ist this way. Does a random node mean
# we ahve to navigate to it randomly?  Do we generate some random path that takes us to the node. Or do we konw the node aprioiri and then navigate to it.
class RandomNode
  def call(root)
    return nil if root == nil
    rand_num = (rand * root.size).ceil
    rand_node(root, rand_num)
  end

  def rand_node(node, node_num)
    return nil if node == nil

    if node_num == node.size
      node
    elsif node.left && node_num <= node.left.size
      rand_node(node.left, node_num)
    else
      left_size = node.left ? node.left.size : 0
      rand_node(node.right, node_num - left_size)
    end
  end
end


class Tree
  attr_accessor :value, :size, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
    @size = 1
  end

  def insert(value)
    Tree.insert_impl(value, self)
  end

  def self.insert_impl(value, node)
    return Tree.new(value) if node == nil
    node.size += 1

    if value <= node.value
      node.left = insert_impl(value, node.left)
    elsif value > node.value
      node.right = insert_impl(value, node.right)
    end

    node
  end

  def self.delete(value, node)
    return nil if node == nil

    if value == node.value
      return_node = nil

      if node.left != nil && node.right != nil
        return_node = node.left
        return_node.left = delete(return_node.value, return_node)
        return_node.right = node.right
      else
        return_node = node.left == nil ? node.right : node.left
      end

      recalculate_size(return_node)
      return return_node
    elsif value <= node.value
      node.left = delete(value, node.left)
    elsif value > node.value
      node.right = delete(value, node.right)
    end

    recalculate_size(node)
    node
  end

  def self.recalculate_size(node)
    return nil if node == nil
    left_size = node.left ? node.left.size : 0
    right_size = node.right ? node.right.size : 0

    node.size = left_size + right_size + 1
  end

  def find(value)
    if value == @value
      return self
    elsif value < @value && @left != nil
      return @left.find(value)
    elsif value > @value && right != nil
      return @right.find(value)
    end

    nil
  end

  def to_s
    "#{value}: Size(#{@size})"
  end

  def inorder
    @left.inorder if @left
    puts @value
    @right.inorder if @right
  end
end

# Tree Test
root = Tree.new(2)

root.insert(1)
root.insert(3)
# debugger
root.insert(4)

puts root
puts root.left
puts root.right
puts root.right.right
puts "INorder"
root.inorder
root = Tree.delete(5, root)
puts "Manual exami"
puts root
puts root.left
puts root.right
puts root.right.right
puts root.right.left
# debugger
puts "afte delete"
root.inorder
puts "Testing finds"
puts root.find(-1)
puts root.find(1)
puts root.find(2)
puts root.find(3)
puts root.find(4)
puts "========== Random Nodes ======="
randy = {}
count = 1000000
count.times do
  node = RandomNode.new.call(root)
  randy[node.value] = 0 if randy[node.value] == nil
  randy[node.value] += 1
end

randy.each do |k, v|
  avg_per = count / randy.size
  diff = v - avg_per
  percent_diff = diff.to_f / avg_per
  puts "#{k}: Diff is #{percent_diff * 100}\%"
end

puts randy
# puts RandomNode.new.call(root)
# puts RandomNode.new.call(root)
# puts RandomNode.new.call(root)
# puts RandomNode.new.call(root)
# puts RandomNode.new.call(root)