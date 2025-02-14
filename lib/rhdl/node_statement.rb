module Rhdl
  class NodeStatement
    attr_reader :ptype, :bits, :name, :type
  
    def initialize(ptype ,name, bits:, type:)
      @ptype = ptype
      @name = name
      @bits = bits
      @type = type
    end
  
    def theptype
      if @ptype == 'input'
        "input wire"
      else
        "output reg"
      end
    end
  
    def generate_terms
      {
        keyword: theptype,
        bitterm: bitterm,
        name:    name
      }
    end
  
  
    def bitterm
      if bits == 1
        nil
      else
        "[#{bits-1}:0]"
      end
    end
  end
end
