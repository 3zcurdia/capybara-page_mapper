
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara/pagemap/version'

Gem::Specification.new do |spec|
  spec.name          = 'capybara-pagemap'
  spec.version       = Capybara::Pagemap::VERSION
  spec.authors       = ['Luis Ezcurdia']
  spec.email         = ['ing.ezcurdia@gmail.com']
  spec.license       = 'MIT'
  spec.summary       = 'Object mapper DSL for capybara'
  spec.description   = 'Simple object mapper for page objects with capybara'
  spec.homepage      = 'https://github.com/3zcurdia/capybara-pagemap'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'capybara', '>= 2.2.0'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'simplecov', '>= 0.13'
  spec.add_development_dependency 'pry', '~> 0.10.3'
  spec.add_development_dependency 'rake', '~> 10.0'
end
