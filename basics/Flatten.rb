require './LLNode.rb'
require './TreeNode.rb'

# Flatten a tree into a linked list
TRAVERSAL_TYPES = [
  PREORDER = :preorder,
  INORDER = :inorder,
  POSTORDER = :postorder,
]

class Flatten
  def initialize(tree)
    @tree = tree
  end

  # Do a traversal
  def call(type = INORDER)
    left_list = nil
    root_node = nil
    right_list = nil

    left_list = Flatten.new(@tree.left).call(type) if @tree.left
    root_node = LLNode.new(@tree.value, nil)
    right_list = Flatten.new(@tree.right).call(type) if @tree.right

    if type == INORDER
      combine_lists(left_list, root_node, right_list)
    elsif type == PREORDER
      combine_lists(root_node, left_list, right_list)
    elsif type == POSTORDER
      combine_lists(left_list, right_list, root_node)
    end
  end

  def combine_lists(n1, *more_lists)
    while more_lists.size > 0
      if n1 == nil
        n1 = more_lists.shift
      else
        next_list = more_lists.shift
        n1 = combine(n1, next_list)
      end
    end

    n1
  end

  def combine(n1, n2)
    if n2 == nil
      n1
    elsif n1 == nil
      n2
    else
      n1.tail.next_node = n2
      n1
    end
  end
end

left_node = TreeNode.new('L1',
  TreeNode.new('L2', nil, nil),
  TreeNode.new('L1R1', nil, nil)
)
right_node = TreeNode.new('R1',
  TreeNode.new('R1L1', nil, nil),
  TreeNode.new('R2', nil, nil)
)
tree_node = TreeNode.new('ROOT',
  left_node,
  right_node
)

flat_list = Flatten.new(tree_node)
puts flat_list.call(PREORDER)
puts flat_list.call()
puts flat_list.call(POSTORDER)
# puts flat_list

