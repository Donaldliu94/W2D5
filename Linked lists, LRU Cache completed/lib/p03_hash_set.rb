class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless include?(key)
      i = key.hash % num_buckets
      self[i] << key
      @count += 1
      if @count > num_buckets
        resize!
      end
    end
  end

  def include?(key)
    i = key.hash % num_buckets
    self[i].include?(key)
  end

  def remove(key)
    if include?(key)
      i = key.hash % num_buckets
      self[i].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    @store[num]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    old_val = @store.flatten

    old_val.each do |num|
      i = num.hash % new_store.size
      new_store[i] << num
    end

    @store = new_store

  end
end
