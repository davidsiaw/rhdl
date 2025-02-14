# frozen_string_literal: true
require 'rhdl'

RSpec.describe Rhdl do
  include Rhdl
  it 'has a version number' do
    expect(Rhdl::VERSION).not_to be nil
  end

  it 'generates simple' do

    contents = <<~CONTENTS
      component "Not" do
        input "a"
        output "y"

        comb do
          y <= !a
        end
      end

    CONTENTS

    dsl = Rhdl::TopDsl.new
    dsl.instance_eval(contents, contents)

    config = Rhdl::GenConfig.new

    vg = Rhdl::VerilogGenerator.new(dsl, config)
    expect(vg.generate_module("Not")).to eq <<~EXPECT
      module Not
      (
        input wire  a,
        output reg  y
      );

      always @(*) begin
        y = !(a);
      end

      endmodule

    EXPECT
  end

  it 'should fail on unknown' do

    contents = <<~CONTENTS
      component "Not" do
        input "a"

        comb do
          y <= !a
        end
      end

    CONTENTS

    dsl = Rhdl::TopDsl.new
    dsl.instance_eval(contents, contents)

    config = Rhdl::GenConfig.new

    vg = Rhdl::VerilogGenerator.new(dsl, config)
    expect{
      vg.generate_module("Not")
    }.to raise_error "undefined variable 'y'"
  end

  it 'should fail on unknown 2' do

    contents = <<~CONTENTS
      component "Not" do
        output "y"

        comb do
          y <= !a
        end
      end

    CONTENTS

    dsl = Rhdl::TopDsl.new
    dsl.instance_eval(contents, contents)

    config = Rhdl::GenConfig.new

    vg = Rhdl::VerilogGenerator.new(dsl, config)
    expect{
      vg.generate_module("Not")
    }.to raise_error "undefined variable 'a'"
  end

  it 'generates from literal zero' do

    contents = <<~CONTENTS
      component "Zero" do
        output "y"

        comb do
          y <= 0
        end
      end

    CONTENTS

    dsl = Rhdl::TopDsl.new
    dsl.instance_eval(contents, contents)

    config = Rhdl::GenConfig.new

    vg = Rhdl::VerilogGenerator.new(dsl, config)
    expect(vg.generate_module("Zero")).to eq <<~EXPECT
      module Zero
      (
        output reg  y
      );

      always @(*) begin
        y = 1'b0;
      end

      endmodule

    EXPECT
  end

  it 'generates from literal one' do

    contents = <<~CONTENTS
      component "One" do
        output "y"

        comb do
          y <= 1
        end
      end

    CONTENTS

    dsl = Rhdl::TopDsl.new
    dsl.instance_eval(contents, contents)

    config = Rhdl::GenConfig.new

    vg = Rhdl::VerilogGenerator.new(dsl, config)
    expect(vg.generate_module("One")).to eq <<~EXPECT
      module One
      (
        output reg  y
      );

      always @(*) begin
        y = 1'b1;
      end

      endmodule

    EXPECT
  end

  it 'generates from a vector of ones' do

    contents = <<~CONTENTS
      component "Vec" do
        output "y", bits: 3

        comb do
          y <= [1, 1, 1]
        end
      end

    CONTENTS

    dsl = Rhdl::TopDsl.new
    dsl.instance_eval(contents, contents)

    config = Rhdl::GenConfig.new

    vg = Rhdl::VerilogGenerator.new(dsl, config)
    expect(vg.generate_module("Vec")).to eq <<~EXPECT
      module Vec
      (
        output reg [2:0] y
      );

      always @(*) begin
        y = {1'b1, 1'b1, 1'b1};
      end

      endmodule

    EXPECT
  end

  it 'generates from a vector of inputs' do

    contents = <<~CONTENTS
      component "Vec" do
        input "a"
        output "y", bits: 3

        comb do
          y <= [a, a, 1]
        end
      end

    CONTENTS

    dsl = Rhdl::TopDsl.new
    dsl.instance_eval(contents, contents)

    config = Rhdl::GenConfig.new

    vg = Rhdl::VerilogGenerator.new(dsl, config)
    expect(vg.generate_module("Vec")).to eq <<~EXPECT
      module Vec
      (
        input wire       a,
        output reg [2:0] y
      );

      always @(*) begin
        y = {a, a, 1'b1};
      end

      endmodule

    EXPECT
  end

  it 'throws error if the input was not the same size' do

    contents = <<~CONTENTS
      component "Vec" do
        input "a"
        output "y", bits: 3

        comb do
          y <= [a, a]
        end
      end

    CONTENTS

    dsl = Rhdl::TopDsl.new
    dsl.instance_eval(contents, contents)

    config = Rhdl::GenConfig.new

    vg = Rhdl::VerilogGenerator.new(dsl, config)
    expect{
      vg.generate_module("Vec")
    }.to raise_error "cannot assign type uint_2 to var uint_3, they are not the same size"
  end
end
