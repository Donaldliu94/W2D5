require "byebug"

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
    # debugger
    nxt = self.next 
    prv = self.prev
    prv.next = nxt
    nxt.prev = prv 
    self.next, self.prev = nil, nil
    self
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @tail.prev == @head
  end

  def get(key)
    self.each do |node|
      if node.key == key
        return node.val
      end
    end
    nil
  end

  def include?(key)

    self.each do |node|
      return true if node.key == key
    end
    return false
  end

  def append(key, val)
    new_ = Node.new(key, val)
    new_.next, new_.prev = @tail, @tail.prev #dont use @head
    @tail.prev.next ,@tail.prev = new_, new_
  end

  def update(key, val)
    self.each do |node|
      if node.key == key
        node.val = val
      end
    end
  end

  def remove(key)

    self.each do |node|

      if node.key == key
        node.prev.next, node.next.prev = node.next, node.prev 
        node.next, node.prev = nil, nil
      end
    end

  end

  def each(&prc)
    start = @head.next
    until start == @tail 
      x = start.next 
      prc.call(start)
      # start = start.next
      start = x
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
