require './TreeNode.rb'
require 'byebug'

# Minimal Tree
# Given a sorted (increasing order) array with unique integer elements, write an algo­rithm to create a binary search tree with minimal height.

class MinimalTree

  def impl(arr, start, finish)
    finish ||= arr.size - 1
    return nil if arr == nil || start > finish
    mid_point = (start + finish) / 2
    median_value = arr[mid_point]

    node = TreeNode.new(median_value)

    node.left = impl(arr, start, mid_point - 1)
    node.right = impl(arr, mid_point + 1, finish)

    node
  end

  def call(arr)
    impl(arr, 0, arr.size - 1)
  end
end

# look at value n/2
# insert into tree
# select n/4 and 3n/4
# => select the mid_point of the A[0..n/2-1] and A[n/2+1..n-1]

# We'll try a sorted array of size betweeen 1 and 33
# And ensure the max depth is no greater than ln(s) + 1

10.times do |node_count|
  arr = []
  (node_count + 1).times do |value|
    arr << value
  end

  arr = arr.sort
  min_tree = MinimalTree.new.call(arr)

  puts "height: #{min_tree.height} for tree w/ #{node_count} nodes"
end