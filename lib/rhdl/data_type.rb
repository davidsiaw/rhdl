module Rhdl
  class DataType
    attr_reader :name, :bits, :parent
  
    def initialize(name, bits, parent)
      @name = name
      @bits = bits
      @parent = parent
    end
  
    def with_bits(bits)
      DataType.new(@name, bits, parent)
    end
  
    def ==(other)
      name == other.name && bits == other.bits
    end
  
    def is_equal_or_child_of(other)
      return false if parent.nil?
      return true if other == self
  
      parent.is_equal_or_child_of(other)
    end
  
    def to_s
      "#{@name}_#{@bits}"
    end
  end
end
