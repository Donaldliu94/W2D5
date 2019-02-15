class MaxIntSet

  attr_reader :max

  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    raise "Out of bounds" if num > max || num < 0

    store[num] = true
  end

  def remove(num)
    store[num] = false

  end

  def include?(num)
    store[num]
  end

  private

  attr_reader :store

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet
  attr_reader :store
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    i = num % store.size
    store[i] << num
  end

  def remove(num)
    i = num % store.size
    store[i].delete(num)
  end

  def include?(num)
    i = num % store.size
    store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      i = num % num_buckets
      @store[i] << num
      @count += 1
    end 

    if count > num_buckets
      resize!
    end
  end
  

  def remove(num)
    if include?(num)
      i = num % num_buckets
      @store[i].delete(num)
      @count -= 1 
    end
  end

  def include?(num)
    i = num % num_buckets
    @store[i].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    old_val = @store.flatten

    old_val.each do |num|
      i = num % new_store.size
      new_store[i] << num
    end

    @store = new_store
  end
end

