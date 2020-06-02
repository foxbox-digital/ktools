
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ktools/version"

Gem::Specification.new do |spec|
  spec.name          = "k-tools"
  spec.version       = KTools::VERSION
  spec.authors       = ["Fernando Schuindt"]
  spec.email         = ["fernando@foxbox.co"]

  spec.summary       = "A set of Bash-like tools to manage DO K8s clusters."
  spec.description   = "KTools is used to help manage, deploy and debug applications on Kubernetes environments."
  spec.homepage      = "https://github.com/foxbox-studios/ktools"
  spec.license       = "MIT"

  spec.files = [
    'lib/ktools.rb',
    'lib/ktools/application.rb',
    'lib/ktools/configuration.rb',
    'lib/ktools/kdb.rb',
    'lib/ktools/setup.rb',
    'lib/ktools/sh.rb',
    'lib/ktools/version.rb',
    'lib/ktools/tools/deliver.rb',
    'lib/ktools/tools/help.rb',
    'lib/ktools/tools/spy.rb',
    'lib/ktools/tools/swap.rb'
  ]

  spec.bindir        = "bin"
  spec.executables   = ["kt"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "pry", "~> 0.12.2"
  spec.add_dependency "colorize", "~> 0.8.1"
  spec.add_dependency "oj", "~> 3.7"
end
