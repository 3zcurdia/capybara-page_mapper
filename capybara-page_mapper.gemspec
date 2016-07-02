# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara/page_mapper/version'

Gem::Specification.new do |spec|
  spec.name          = "capybara-page_mapper"
  spec.version       = Capybara::PageMapper::VERSION
  spec.authors       = ["Luis Ezcurdia"]
  spec.email         = ["ing.ezcurdia@gmail.com"]

  spec.summary       = %q{Page objects DSL}
  spec.description   = %q{Page objects DSL for capybara}
  spec.homepage      = "https://github.com/3zcurdia/capybara-page_mapper"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "capybara", "~> 2.7.1"

  spec.add_development_dependency "pry", "~> 0.10.3"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "poltergeist", "~> 1.10.0"
end
