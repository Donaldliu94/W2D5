require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  
  def set(key, val)
    i = bucket(key)
    unless include?(key)
      @store[i].append(key,val)
      @count += 1
      if @count > num_buckets
        resize!
      end
    else
      @store[i].update(key,val)
    end
  end
  
  def get(key)
    if include?(key)
      i = bucket(key)
      @store[i].get(key)
    end
  end
  
  def delete(key)
    i = bucket(key)
    @count -= 1
    @store[i].remove(key)
  end
  include Enumerable

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |node|
        prc.call(node.key, node.val)
      end
    end
    return self 
  end
  

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end
  
  alias_method :[], :get
  alias_method :[]=, :set
  
  private
  
  def num_buckets
    @store.length
  end
  
  def resize!
    new_array = Array.new(num_buckets * 2) {LinkedList.new}

    self.each do |key, value|
      i = key.hash % new_array.size
      new_array[i].append(key, value)
    end
    @store = new_array

  end
  
  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    i = key.hash % num_buckets
  end
end
