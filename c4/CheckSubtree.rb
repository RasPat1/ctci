require './TreeNode.rb'

# Check Subtree
# T1 and T2 are two very large binary trees, with T1 much bigger than T2. Create an algorithm to determine if T2 is a subtree of T1.
# A tree T2 is a subtree of T1 if there exists a node n in T1 such that the subtree of n is identical to T2. That is, if you cut off the tree at node n, the two trees would be identical.

# Hints:#4, #11, #18, #31, #37

# Okay okayokayokay
# Welllll.
# So let's start at the leaves
# T2 must have leaves
# And those leaves must also be leaves in T1 if T2 is a subtree of T1
# So What if we got all the leaves of T1 and said
# okay if the leaves (in order) of T1 in clude the leaves of T2 we can continue
# And we may have multiple matches but let's look at all those matches
# and say that is where we start. Those are candidates.
# Also If we're doing an indorer traversal of the tree
# Shouldn't an in order traversal of T1 include a section that is equivalent to the inorder traversal of T2?  It doesn't meant that T2 is a subtree of T1 but it does give us a place to look right/ tell us if it's not
# I mean the burte force way is okay go luck for the root of T2.
# But they are binary trees not binary search trees
# So search is O(n) time
# basic alg w/ brute force
# Find all nodes in T1 that have the same value of root of T2
# Also here we are assuming that the trees are allowed to have duplicate values, and that a subtree is identical if the values of all its nodes and the connections betewen them is the same as T2. They ar different nodes... but have the same value and connectivity. We could define somethine lse here. We use the word identical in the question which is vague in this context.
# Anyways.
# Find all nodes in T1 where value == T2.root
# Then recursively check subtree for T1.candidate.left and T2.root.left and T1.candidate.right. This will work but won't be very efficient
# We coudl also augment the node to include values liek depth that could speed up the process but I think only by constant factors
# The optimal-est option would be O(|T2|) I hope. Only way to get here is to do that bottom up idea though. And to get references or to even see the value of the leaves of T1 we'd have to go at least lg|T1| steps right. Also that's assuming balanced. If not balanced then worst case we'd walk |T1| steps just to see a leaf. And in fact we can construct an example that is a linear T1 with liek one node at the end and T2 is just that node. This has to take minimum |T2| steps.  So best case is probably O(T1 + T2) and since T1 >> T2 we can say O(|T1|)
# okay back to the problem
# So doing a search for T2 root and then checking subtree seems easy
# But what else do we got!?!?!?
# Let's start all the way on the left
# Let's match the leftmost leaf in T1 to the leftmost leaf in T@
# If its a match continue exploring upward to see if it containues matching
# If teh whole thing is a match we're great
# If it's not let's check the next leaf
# We keep moving until we find the place where the leftmost leaf of T1 and teh leftmost leaf of T2 overlap
# Worst case scenario would be we find the match at every left leaf node but we actaulyl don't ahve that many candidate leaf nodes
# drawing it out
# it looks like it'd be 2^(h1 - h2) candidates. Basically the number of nodes that could be roots of height h2. But also this assumes that its balanced whic his not true.
# How about this
# we get the hwight of T1 and T2
# Then we look at all nodes of T1 at height h2. That's up to 2^(h1-h2) nodes which is still a lot
# maybe we can convert T2 into an inorder traversal with like slightly more info such that any other tree with the same inorder travversal would have a slightly different representation
# we actually only want to konw if there subsections of each otehr
# So how about we do this
# inorder tranversal of T1 while appending 'L' before each left, 'Z' before each root and 'R' before each Right adn then inorder tranversal of T2 usign the same method
# and then search for T2-representation in T1-representation
# inorder traversal is O(|T1|) and the string search can be done in linear time with KMP or some other linear is_substring  so that's also O(|T1|) yeah. This is linear in T1 runtime and O(T1) in memory


class CheckSubtree
  def call(t1, t2)
    rep1 = inorder_rep(t1)
    rep2 = inorder_rep(t2)

    puts rep2

    is_substring(rep1, rep2)
  end

  # let's keep concatenating into an array since ruby uses
  # table doubling to make dynamic lists convenient
  def inorder_rep(tree)
    return "" if tree == nil

    left = inorder_rep(tree.left)
    root = tree.value
    right = inorder_rep(tree.right)

    ["L#{left}","Z#{root}","R#{right}"].join('')
  end

  def is_substring(rep1, rep2)
    rep1.index(rep2) != nil
  end
end

root =
TreeNode.new(4,
  TreeNode.new(1,
    TreeNode.new(-1,
      TreeNode.new(-2,
        TreeNode.new(-3,
          TreeNode.new(-4)
        )
      )
    ),
    TreeNode.new(2)
  ),
  TreeNode.new(6,
    TreeNode.new(1),
    TreeNode.new(7,
      TreeNode.new(8)
    )
  )
)
r2 =
TreeNode.new(6,
  TreeNode.new(1),
  TreeNode.new(7,
    TreeNode.new(8)
  )
)
r3 =
TreeNode.new(-2,
  TreeNode.new(-3,
    TreeNode.new(-4)
  )
)
r4 = TreeNode.new(10)

puts CheckSubtree.new.call(root, r2)
puts CheckSubtree.new.call(root, r3)
puts CheckSubtree.new.call(root, r4)