require './BST.rb'
class BSTSpec
  MIN_VAL = -1000
  MAX_VAL = 1000

  def test
    test_create
    test_insert
    test_search
  end

  def test_create
    BST.new(rand_val)
    puts "Test Passed: Create"
  end

  def test_insert
    val = rand_val
    tree = BST.new(val)
    tree.insert(val + 2)
    fail unless tree.right != nil
    fail unless tree.right.value >= tree.value
    fail unless tree.left == nil

    tree.insert(val - 2)
    fail unless tree.left != nil
    fail unless tree.left.value <= tree.value

    tree.insert(val + 1)
    fail unless tree.right.left != nil
    fail unless tree.right.right == nil
    fail unless tree.right.value >= tree.right.left.value
    tree.insert(val + 3)
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
      tree.insert(new_val)
    end
    values.each do |new_val|
      fail unless tree.search(new_val) != nil
    end
    other_values.each do |other_val|
      fail unless tree.serach(other_val) == nil
    end
  end

  def fail
    raise Exception.new
  end

  def rand_val(low = MIN_VAL, high = MAX_VAL)
    rand * (high - low) + low
  end
end

BSTSpec.new.test