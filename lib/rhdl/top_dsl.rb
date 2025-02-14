module Rhdl
  class TopDsl
    attr_reader :contents
    def initialize
      @components = {}
      @contents = {
        components: @components
      }
    end

    def component(name, &block)
      raise "component '#{name}' already defined" if @components[name]
      @components[name] = Component.new(name, self, Proc.new(&block))

    end
  end
end
