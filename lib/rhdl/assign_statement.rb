module Rhdl
  class AssignStatement < Statement
    def initialize(var_name, expr)
      @var_name = var_name
      @expr = expr
    end
  
    def generate
      [
        #"//#{@expr.varnames};",
        "#{@var_name} = #{@expr.generate};"
      ]
    end
  
    def check!(check_context)
      out_type = @expr.get_output_type(check_context)
      var_type = check_context.get_var_type(@var_name)

      # assignment type check
      if out_type.is_equal_or_child_of(var_type)
        raise "cannot assign type #{out_type} to var #{var_type}"
      end

      if out_type.bits != var_type.bits
        raise "cannot assign type #{out_type} to var #{var_type}, they are not the same size"
      end

      @expr.fanout(check_context, self)
      check_context.notify_driver(@var_name, self)

    end
  end
end
