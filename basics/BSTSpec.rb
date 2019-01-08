require './BST.rb'
class BSTSpec
  MIN_VAL = -1000
  MAX_VAL = 1000

  def test
    test_create
    test_insert
    test_search
    test_delete
    test_valid?
    test_inorder
  end

  def test_create
    BST.new(rand_val)
    puts "Test Passed: Create"
  end

  def test_insert
    val = rand_val
    tree = BST.new(val)
    BST.insert(tree, val + 2)
    fail unless tree.right != nil
    fail unless tree.right.value >= tree.value
    fail unless tree.left == nil

    BST.insert(tree, val - 2)
    fail unless tree.left != nil
    fail unless tree.left.value <= tree.value

    BST.insert(tree, val + 1)
    fail unless tree.right.left != nil
    fail unless tree.right.right == nil
    fail unless tree.right.value >= tree.right.left.value
    BST.insert(tree, val + 3)
    fail unless tree.right.right != nil
    fail unless tree.right.value <= tree.right.right.value
    puts "Test Passed: Insert"
  end

  def test_search
    val = rand_val
    tree = BST.new(val)
    values = [
      val + 1, val + 2, val - 1, val - 2
    ]
    other_values = [
      val + 100, val - 100
    ]
    values.each do |new_val|
      BST.insert(tree, new_val)
    end
    values.each do |new_val|
      fail unless BST.search(tree, new_val) != nil
    end
    other_values.each do |other_val|
      fail unless BST.search(tree, other_val) == nil
    end

    puts "Test Passed: Search"
  end

  def test_delete
    root = BST.insert(nil, 1)
    BST.insert(root, 2)
    BST.insert(root, 3)
    BST.insert(root, 4)
    BST.insert(root, 0)
    BST.insert(root, -1)

    BST.delete(root, 1)
    fail unless BST.search(root, 1) == nil

    BST.delete(root, 4)
    fail unless BST.search(root, 4) == nil

    BST.delete(root, 0)
    fail unless BST.search(root, 0) == nil

    BST.delete(root, 2)
    fail unless BST.search(root, 2) == nil
    puts "Test Passed: Delete"
  end

  def test_valid?
    root = BST.insert(nil, 1)
    BST.insert(root, 2)
    BST.insert(root, -1)

    fail unless BST.valid?(root)
    root.right.value = -1

    fail unless BST.valid?(root) == false
    root.left.value = 2

    fail unless BST.valid?(root) == false
    puts "Test Passed: Valid"
  end

  def test_inorder
    root = BST.insert(nil, 0)

    nums = [*1..10].shuffle
    nums.each do |num|
      BST.insert(root, num)
    end

    nums << 0
    nums = nums.sort
    inorder = BST.inorder(root)

    fail unless inorder == nums

    puts "Test Passed: Inorder"
  end

  def fail
    raise Exception.new
  end

  def rand_val(low = MIN_VAL, high = MAX_VAL)
    rand * (high - low) + low
  end
end

BSTSpec.new.test