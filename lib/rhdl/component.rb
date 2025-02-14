module Rhdl
  class Component
    def initialize(name, topdsl, theproc)
      @name = name
      @topdsl = topdsl
      @proc = theproc
      @component_dsl = nil
      @inputs = []
      @outputs = []
      @wires = []
      @comb_block_dsl = []
    end
  
    def inputs
      implement!
  
      @inputs
    end
  
    def outputs
      implement!
  
      @outputs
    end
  
    def wires
      implement!
  
      @wires
    end
  
    def comb_block_dsl
      implement!
  
      @comb_block_dsl
    end
  
    def implement!
      return unless @component_dsl.nil?
  
      component_dsl = ComponentDsl.new(@topdsl)
      component_dsl.instance_eval(&@proc)
  
      @inputs = []
      component_dsl.inputs.each do |k,v|
        @inputs << v
      end
  
      @outputs = []
      component_dsl.outputs.each do |k,v|
        @outputs << v
      end
  
      @wires = []
      component_dsl.wires.each do |k,v|
        @wires << v
      end
  
      @comb_block_dsl = component_dsl.comb_block_dsl
  
      check!(component_dsl)
  
      @component_dsl = component_dsl
    end
  
    def check!(component_dsl)
      cc = CheckContext.new
      component_dsl.inputs.each do |k,v|
        cc.add_input_variable(k, v)
      end
  
      component_dsl.outputs.each do |k,v|
        cc.add_output_variable(k, v)
      end
  
      component_dsl.wires.each do |k,v|
        cc.add_wire_variable(k, v)
      end
  
  
      component_dsl.comb_block_dsl.statements.each do |s|
        s.check!(cc)
      end

      cc.fanout_check!
    end
  
  end
end
