class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    result = 0
    result -= self.size.hash
    self.each_with_index do |ele, i|
      if ele.is_a?(Array)
        result += Array.hash
      elsif ele.is_a?(Integer)
        result += ele.hash
      elsif ele.is_a?(String)
        result += ele.hash 
      elsif ele.is_a?(Hash)
        result += ele.hash 
      end

      result -= i.hash 
      if result.odd?
        result += result % 5
      else
        result += result % 3
      end

      result *= -1
    end
    return result
  end
end

class String
  def hash
    result = 0
    self.chars.each do |ch|
      result += ch.ord 
      result * -1 
      if result.odd?
        result += result % 5
      else
        result += result % 3
      end

      result *= self.length
    end
    return result 
  end

end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    0
  end
end
