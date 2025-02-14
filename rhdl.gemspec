# frozen_string_literal: true

require_relative 'lib/rhdl/version'

Gem::Specification.new do |spec|
  spec.name          = 'rhdl'
  spec.version       = Rhdl::VERSION
  spec.authors       = ['David Siaw']
  spec.email         = ['874280+davidsiaw@users.noreply.github.com']

  spec.summary       = 'Rhdl summary'
  spec.description   = 'Rhdl description'
  spec.homepage      = 'https://github.com/davidsiaw/rhdl'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/davidsiaw/rhdl'
  spec.metadata['changelog_uri'] = 'https://github.com/davidsiaw/rhdl'

  spec.files         = Dir['{exe,data,lib}/**/*'] + %w[Gemfile rhdl.gemspec]
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop'
end
