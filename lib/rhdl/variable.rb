module Rhdl
  class Variable < Expression
    def initialize(name, owner)
      @name = name.to_s
      @owner = owner
    end
  
    def <=(rhs)
      @owner.add_assign_statement(@name, rhs)
      nil
    end
  
    def varnames
      [@name]
    end
  
    def generate
      "#{@name}"
    end
  
    def get_output_type(check_context)
      check_context.get_var_type(@name)
    end

    def fanout(check_context, statement)
      check_context.notify_fanout(@name, statement)
    end

  end
end
