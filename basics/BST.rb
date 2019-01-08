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
  def self.delete(root, value)
    # if our root is nil lets return nil we're done
    # if we don't find the value we're done
    # if we find the value and it's got no children delete it
    # if we find the value and it's got 1 child, replace teh node with a childe
    # if we find the value and it's got 2 children, replace teh node with its succesor and delete teh succesor (recurse)

    return nil if root == nil

    if value > root.value
      root.right = BST.delete(root.right, value)
    elsif value < root.value
      root.left = BST.delete(root.left, value)
    elsif value == root.value
      # if it has 1 or no children
      if root.right == nil
        return root.left
      elsif root.left == nil
        return root.right
      end

      # If it has 2 children
      root.value = BST.min_value(root.right)
      root.right = BST.delete(root.right, root.value)
    end

    root
  end

  def self.min_value(root)
    while root.left != nil
      root = root.left
    end

    root.value
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

  def self.inorder(node, nodes = [])
    return [] if node == nil

    nodes += inorder(node.left)
    nodes += [node.value]
    nodes += inorder(node.right)

    nodes
  end

  def self.postorder(node, nodes = [])
    return [] if node == nil

    nodes += [node.value]
    nodes += inorder(node.left)
    nodes += inorder(node.right)

    nodes
  end

  def self.valid?(node)
    return true if node == nil

    return false if node.right && node.value > node.right.value
    return false if node.left && node.value <= node.left.value

    return false unless BST.valid?(node.left)
    return false unless BST.valid?(node.right)

    true
  end

  # Extra credit: Balance the tree when this is called
  def balance
  end
end