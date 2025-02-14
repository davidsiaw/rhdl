module Rhdl
  class UnOp < Expression
    def initialize(lhs, op)
      @lhs = lhs
      @op = op
    end
  
    def varnames
      @lhs.varnames
    end
  
    def generate
      "!(#{@lhs.generate})"
    end
  
    def fanout(check_context, statement)
      @lhs.fanout(check_context, statement)
    end
  
    def get_output_type(check_context)
      ltype = @lhs.get_output_type(check_context)
      if @op == "!"
  
        if ltype.to_s != "uint_1"
           raise "& does not support types #{ltype}"
        end
  
        return ltype
      else
        raise "unknown operation '#{op}'"
      end
    end
  end
end
