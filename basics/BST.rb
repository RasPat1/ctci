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
  def insert(value)
    if value >= self.value
      if self.right == nil
        self.right = BST.new(value)
      else
        self.right.insert(value)
      end
    elsif value < self.value
      if self.left == nil
        self.left = BST.new(value)
      else
        self.left.insert(value)
      end
    end
  end

  # Delete a node with the given value
  # Return true if it was deleted return false if it was not
  def delete(value)
  end

  # Return the node if the value exists and nil if it does not
  # Alt: return true if the value exists
  def search(value)
    if value > self.value
      if self.right != nil
        return nil

  end

  # Extra credit: Balance the tree when this is called
  def balance
  end
end