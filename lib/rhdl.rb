# frozen_string_literal: true

require 'rhdl/version'
require 'rhdl/top_dsl.rb'
require 'rhdl/component.rb'
require 'rhdl/data_type.rb'
require 'rhdl/check_context.rb'
require 'rhdl/node_statement.rb'
require 'rhdl/expression.rb'
require 'rhdl/un_op.rb'
require 'rhdl/bin_op.rb'
require 'rhdl/variable.rb'
require 'rhdl/statement.rb'
require 'rhdl/assign_statement.rb'
require 'rhdl/block_dsl.rb'
require 'rhdl/component_dsl.rb'
require 'rhdl/gen_config.rb'
require 'rhdl/module_generator.rb'
require 'rhdl/verilog_generator.rb'

module Rhdl
  class Error < StandardError; end
  # Your code goes here...
end
