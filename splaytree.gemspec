# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'splaytree/version'

Gem::Specification.new do |spec|
  spec.name          = "splaytree"
  spec.version       = Splaytree::VERSION
  spec.authors       = ["Artur Babagulyyev"]
  spec.email         = ["artur.babagulyyev@gmail.com"]

  spec.summary       = %q{Splay Tree Data Structure}
  spec.description   = %q{A splay tree is a self-adjusting binary search tree with the additional property that recently accessed elements are quick to access again. It performs basic operations such as insertion, look-up and removal in O(log n) amortized time.}
  spec.homepage      = "https://github.com/SnowDiamond/splaytree"
  spec.license       = "MIT"

  spec.files = ['lib/splaytree.rb', 'lib/splaytree/node.rb', 'lib/splaytree/version.rb']

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "minitest-reporters", "~> 1.1"
end
