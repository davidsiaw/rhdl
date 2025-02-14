module Rhdl
  class ComponentDsl
    attr_reader :inputs, :outputs, :wires, :comb_block_dsl
  
    def initialize(topdsl)
      @topdsl = topdsl
      @inputs = {}
      @outputs = {}
      @wires = {}
      @comb_block_dsl = nil
    end
  
    def input(name, bits: 1, type: "uint")
      @inputs[name] = NodeStatement.new('input', name, bits: bits, type: type)
    end
  
    def output(name, bits: 1, type: "uint")
      @outputs[name] = NodeStatement.new('output', name, bits: bits, type: type)
    end

    def wire(name, bits: 1, type: "uint")
      @wires[name] = NodeStatement.new('wire', name, bits: bits, type: type)
    end
  
    def comb(&block)
      raise "Combinational block already defined" if !@comb_block_dsl.nil?
  
      @comb_block_dsl = BlockDsl.new
      @comb_block_dsl.instance_eval(&block)
    end
  end
end
