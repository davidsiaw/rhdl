# rhdl

Ruby Hardware Description Language

This is a Ruby DSL that allows you to describe digital circuitry for an ASIC or FPGA, and compiles it to verilog.


Not finished.


Aspirations:
- fail to compile on undriven wires and registers
- pedantically fail on possible mistakes by default like unused variables
- only allow synthesizable
- simplify 2-block style of verilog
- allow typing variables strongly
- simplify generation of repetitive complex circuits
- be more intuitive
- less room for error
- strongly prevent latches (need to be instatiated on purpose)
- global async reset configuration
- automatic reset implementation
- implicit clock and reset passing by default unless specified
- generate constraints file from top module for certain fpgas
- generate hopfully readable verilog
- formal method primitives
- prevent verilog antipatterns/mistakes
- easy module generation and driving inputs and receiving outputs


Things it cannot do:
- inout
- analog circuits


Example

```ruby
component "And" do
  input "a"
  input "b"
  output "y"

  comb do
    y <= a & b
  end
end

```


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rhdl'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rhdl

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davidsiaw/rhdl. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/davidsiaw/rhdl/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rhdl project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/davidsiaw/rhdl/blob/master/CODE_OF_CONDUCT.md).
