module Rhdl
  class BlockDsl
  
    class ::Integer
      def generate
        "1'b#{to_s}"
      end

      def fanout(check_context, statement)
        # literals can fanout anytime
      end

      def get_output_type(check_context)
        if self == 0 || self == 1
          return DataType.new("uint", 1, nil)
        end

        raise 'integer literal other than 0 or 1 not supported'
      end
    end

    class ::Array
      def generate
        "{#{self.map{|x| x.generate}.join(', ')}}"
      end

      def fanout(check_context, statement)
        self.each do |x|
          x.fanout(check_context, statement)
        end
      end

      def get_output_type(check_context)
        totalbits = self.flatten.sum{|x| x.get_output_type(check_context).bits}
        DataType.new("uint", totalbits, nil)
      end
    end

    attr_reader :statements
    def initialize
      @variables = {}
      @statements = []
      @trap = false
    end
  
    def method_missing(name, *args)
      super if args.length != 0
      super if @trap
  
      @trap = true
      v = @variables[name]
      if v.nil?
        v = Variable.new(name, self)
        @variables[name] = v
      end
      @trap = false
      v
    end
  
    def add_assign_statement(var_name, expr)
      @statements << AssignStatement.new(var_name, expr)
    end
  
  end
end