class LL
  attr_accessor :head, :tail
  def initialize(head = nil, tail = nil)
    @head = head
    @tail = tail
  end

  def add_to_tail(node)
    if @tail != nil
      @tail.next = node
    else
      @head = node
    end

    @tail = node
  end

  def add_to_head(node)
    node.next = @head
    if @tail == nil
      @tail = node
    end
    @head = node
  end

  def to_s
    s = []
    node = @head

    while node != nil
      s << node.value
      node = node.next
    end

    s.join("=>")
  end
end