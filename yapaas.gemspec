# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yapaas/version'

Gem::Specification.new do |spec|
  spec.name          = "yapaas"
  spec.version       = YAPAAS::VERSION
  spec.authors       = ["JJ Buckley"]
  spec.email         = ["jj@bjjb.org"]

  spec.summary       = 'Yet Another Platform as a Service'
  spec.description   = <<-DESC
Helps set up and manage clusters of nodes on the cloud which contribute to
a platform, onto which you can install pretty much anything you like.
  DESC
  spec.homepage      = 'http://bjjb.github.io/yapaas'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "cucumber", "~> 2.4.0"
  spec.add_development_dependency "simplecov", "~> 0.12.0"
end
