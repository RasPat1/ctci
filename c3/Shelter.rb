
# Animal Shelter
# An animal shelter, which holds only dogs and cats, operates on a strictly "first in, first out" basis. People must adopt either the "oldest" (based on arrival time) of all animals at the shelter, or they can select whether they would prefer a dog or a cat (and will receive the oldest animal of that type). They cannot select which specific animal they would like. Create the data structures to maintain this system and implement operations such as enqueue, dequeueAny, dequeueDog, and dequeueCat. You may use the built-in Linked list data structure.

CAT = :cat
DOG = :dog

class Shelter
  # right can't we just do this?
  # Use 2 queues, dog q and cat q
  # and then whenever they're enqueued make a node with an id or timestamp and then or dequeue any we can just comapre the stamps to detemine who was added first
  # BUT they say use linked list
  # Sooooo
  # we could just have a head and tail with a pointer to the oldest dog and cat
  def initialize
    @cat_q = Queue.new
    @dog_q = Queue.new
  end

  def enqueue(node)
    if node.type == CAT
      @cat_q.add(node)
    elsif node.type == DOG
      @dog_q.add(node)
    end
  end

  def dequeueAny
    cat = @cat_q.peek
    dog = @dog_q.peek
    if dog == nil || (cat != nil && cat.id < dog.id)
      dequeueCat
    else
      dequeueDog
    end
  end

  def dequeueDog
    @dog_q.remove
  end

  def dequeueCat
    @cat_q.remove
  end
end

class AnimalNode
  @@id = 0

  attr_accessor :type, :id, :next
  def initialize(type, next_animal)
    @@id += 1
    @id = @@id
    @type = type
    @next = next_animal
  end
end

class ShelterLL
  # oh if we do have oldest cat / dog
  # everytiume we adopt them we may have to search
  # the whole list for the next oldest cat/dog
  # So might as well jsut do 2 Qs. Thats better

  def initialize
    @head = nil
    @tail = nil
    @oldest
  end
end