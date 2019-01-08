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

  def self.preorder(node, nodes = [])
    return [] if node == nil

    nodes += [node.value]
    nodes += preorder(node.left)
    nodes += preorder(node.right)

    nodes
  end

  def self.postorder(node, nodes = [])
    return [] if node == nil

    nodes += postorder(node.left)
    nodes += postorder(node.right)
    nodes += [node.value]

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

  # Construct a tree from a given preorder traversal
  # Runtime: O(n^2)
  def self.construct_from_preorder(arr)
    # The first element of the array is the root
    # then get the elements from index 1 until
    # the first value that's larger than the root value
    # That's the left subtree
    # Everythign from the first value larger than the root value until the
    # end of the array is in the right subtree
    return nil if arr.size == 0
    root = BST.insert(nil, arr[0])
    left_subarray = []
    right_subarray = []

    arr.each_index do |index|
      next if index == 0

      if arr[index] >= root.value
        right_subarray = arr[index..-1]
        break
      end
      left_subarray << arr[index]
    end

    root.left = BST.construct_from_preorder(left_subarray)
    root.right = BST.construct_from_preorder(right_subarray)

    root
  end

  # Construct a tree form a given preorder tranversal
  # Runtime: O(n)
  def self.fast_preorder_construction(arr, min = nil, max = nil)
    # Set a min and max for each node
    # As we add a value we use its parent to update the min or max value depending
    # on whether its a left or right subtree
    return nil if arr.size == 0
    root = BST.insert(nil, arr[0])


  end

  # Extra credit: Balance the tree when this is called
  def balance
  end
end