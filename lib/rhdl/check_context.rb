module Rhdl
  class CheckContext
    def initialize
      @variables = {}
      @types = {
        "uint" => DataType.new("uint", 1, nil)
      }
    end
  
    def add_input_variable(name, paramstatement)
      raise "#{name} is already defined" if @variables[name]
  
      @variables[name] = {
        name: name,
        role: :input,
        kind: :wire,
        fanout: [],
        driver: true, # always driven
        type: @types[paramstatement.type].with_bits(paramstatement.bits)
      }
    end
  
    def add_output_variable(name, paramstatement)
      raise "#{name} is already defined" if @variables[name]
  
      @variables[name] = {
        name: name,
        role: :output,
        kind: :wire,
        fanout: true,
        driver: nil,
        type: @types[paramstatement.type].with_bits(paramstatement.bits)
      }
    end

    def add_wire_variable(name, paramstatement)
      raise "#{name} is already defined" if @variables[name]
  
      @variables[name] = {
        name: name,
        role: :output,
        kind: :wire,
        fanout: [],
        driver: nil,
        type: @types[paramstatement.type].with_bits(paramstatement.bits)
      }
    end
  
    def add_register_variable(name, paramstatement)
      raise "#{name} is already defined" if @variables[name]
  
      @variables[name] = {
        name: name,
        role: :internal,
        kind: :register,
        fanout: [],
        driver: nil,
        type: @types[paramstatement.type].with_bits(paramstatement.bits)
      }
    end
  
    def get_var_type(name)
  
      if @variables[name].nil?
        raise "undefined variable '#{name}'"
      end
  
      @variables[name][:type]
    end

    def notify_fanout(name, statement)
      if @variables[name].nil?
        raise "variable #{name} does not exist"
      end

      @variables[name][:fanout] << statement
    end

    def notify_driver(name, statement)
      if @variables[name].nil?
        raise "variable #{name} does not exist, and cannot be driven"
      end
      unless @variables[name][:driver].nil?
        raise "variable #{name} is already being driven"
      end

      @variables[name][:driver] = statement
    end

    def fanout_check!

      @variables.each do |name, var|
        used = var[:fanout] == true || var[:fanout].length > 0
        driven = !var[:driver].nil?

        if used && !driven
          raise "variable #{name} not driven but used"
        end

        if !used && driven
          raise "variable #{name} driven but not used"
        end

        if !used && !driven
          raise "variable #{name} completely unused"
        end
      end
    end

  end
end
