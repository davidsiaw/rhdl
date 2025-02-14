module Rhdl
  class ModuleGenerator
    attr_reader :module_name, :component
  
    def initialize(module_name, component)
      @module_name = module_name
      @component = component
    end
  
    def maxlens
      @maxlens ||= begin
        res = {}
        params.each do |paraminfo|
          paraminfo.each do |key, val|
            res[key] ||= 0
            len = (val&.length || 0)
            if res[key] < len
              res[key] = len
            end
          end
        end
  
        res
      end
    end
  
    def params
      @params ||= [] +
        component.inputs.map{|x| x.generate_terms} +
        component.outputs.map{|x| x.generate_terms}
    end
  
    def params_arr
      @params_arr ||= begin
        res = []
        params.each do |paraminfo|
          arr = []
          paraminfo.each do |key, val|
            if val.nil?
              arr << "".ljust(maxlens[key])
              next
            end
  
            arr << val.ljust(maxlens[key])
          end
          res << "  #{arr.join(' ')}"
        end
        res
      end
    end
  
    def params_stmt
      @params_stmt ||= params_arr.join(",\n")
    end
  
    def comb_block
      @comb_block ||= component.
        comb_block_dsl.
        statements.
        map{|x| x.generate}.flatten.map{|x| "  #{x}"}.
        join("\n")
    end

    def wire_list
      component.wires.map do |x|
        terms = x.generate_terms
        "reg #{terms[:bitterm]} #{terms[:name]}; // wire"
      end.join("\n")
    end
  
    def generate
      result = <<~CONTENT
        module #{module_name}
        (
        #{params_stmt}
        );
        #{wire_list}
        always @(*) begin
        #{comb_block}
        end
  
        endmodule
  
      CONTENT
  
      result
    end
  end
end
