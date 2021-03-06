# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lisp/version'

Gem::Specification.new do |spec|
  spec.name          = "lisp"
  spec.version       = Lisp::VERSION
  spec.authors       = ["Scott LaBounty"]
  spec.email         = ["slabounty@gmail.com"]

  spec.summary       = %q{A small scheme interpreter in ruby as a gem. }
  spec.description   = %q{A small scheme interpreter in ruby as a gem. }
  spec.homepage      = "https://github.com/slabounty/lisp"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "simplecov", "0.12"
  spec.add_development_dependency "coveralls", '~> 0.7'
end
