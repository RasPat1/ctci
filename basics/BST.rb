# Implement a Binary Search Tree
# It does not have to balance itself
class BST
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end

  # Create a node with the given value and return the root
  def self.insert(root, value)
    if root == nil
      root = BST.new(value)
    elsif value >= root.value
      root.right = BST.insert(root.right, value)
    elsif value < root.value
      root.left = BST.insert(root.left, value)
    end

    root
  end

  # Delete a node with the given value
  # Return true if it was deleted return false if it was not
  def delete(value)
   #        6
   #     2     7
   #   0   4
   # -2 1 3 5
  end

  # Return the node if the value exists and nil if it does not
  def self.search(node, value)
    return nil if node == nil
    return node if node.value == value

    if value > node.value
      BST.search(node.right, value)
    elsif value < node.value
      BST.search(node.left, value)
    end
  end

  # Extra credit: Balance the tree when this is called
  def balance
  end
end