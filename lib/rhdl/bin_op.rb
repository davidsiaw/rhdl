module Rhdl
  class BinOp < Expression
    def initialize(lhs, rhs, op)
      @lhs = lhs
      @rhs = rhs
      @op = op
    end
  
    def varnames
      @lhs.varnames + @rhs.varnames
    end
  
    def generate
      "(#{@lhs.generate} #{@op} #{@rhs.generate})"
    end

    def fanout(check_context, statement)
      @lhs.fanout(check_context, statement)
      @rhs.fanout(check_context, statement)
    end
  
    def get_output_type(check_context)
      ltype = @lhs.get_output_type(check_context)
      rtype = @rhs.get_output_type(check_context)
      if @op == "&"
  
        if ltype.to_s != "uint_1" ||
           rtype.to_s != "uint_1"
           raise "& does not support types #{ltype} and #{rtype}"
        end
  
        return ltype
      else
        raise "unknown operation '#{op}'"
      end
    end
  end
end
