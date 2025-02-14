module Rhdl
  class Expression
    def varnames
      []
    end
  
    def &(rhs)
      BinOp.new(self, rhs, "&")
    end
  
    def !()
      UnOp.new(self, "!")
    end
  
    def generate
      "<notimpl>"
    end

    def fanout(check_context, statement)
      raise "fanout(check_context, statement) not implemented"
    end
  
    def get_output_type(check_context)
      raise "get_output_type(check_context) not implemented"
    end
  end
end
