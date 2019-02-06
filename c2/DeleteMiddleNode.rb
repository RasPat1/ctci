require './Node.rb'
# Delete Middle Node
# Implement an algorithm to delete a node in a
# singly linked list that is not the first or last node
# Given only access to the node to delete
# a->b->c->d->e->f
# We're given access to "c"
# Delete c
# But make sure list still ooks like
# a->b->d->e->f
class DeleteMiddleNode
  def call(node)
    while node.next_node != nil
      node.value = node.next_node.value

      if node.next_node.next_node == nil
        node.next_node = nil
      else
        node = node.next_node
      end
    end


  end
end


ll = Node.new('a')
['b', 'c', 'd', 'e', 'f'].each do |val|
  ll.append_to_end(Node.new(val))
end

puts "#{ll}"

node_to_delete = ll.next_node.next_node
DeleteMiddleNode.new.call(node_to_delete)
puts ll