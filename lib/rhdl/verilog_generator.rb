module Rhdl
  class VerilogGenerator
    def initialize(dsl, config)
      @dsl = dsl
      @config = config
    end
  
    def generate_module(module_name)
      thing = @dsl.contents[:components][module_name]
  
      ModuleGenerator.new(module_name, thing).generate
    end
  end
end
