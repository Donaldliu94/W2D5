require "byebug"
require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    # debugger
    if @map.include?(key)
      ru = @map[key].remove
      @store.append(ru.key, ru.val)
        @map[key] = @store.last
      ru.val
    elsif count < @max
      # debugger
      val = @prc.call(key)
      # debugger
      @store.append(key, val)
      @map[key] = @store.last
      val
    else
      ejected = @store.first.remove
      @map.delete(ejected.key)
      #eject LRU node ^, appends new node V
      val = @prc.call(key)
      @store.append(key,val)
      @map[key] = @store.last
      val
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
  end
end
