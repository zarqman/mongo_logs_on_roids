# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mongo_logs_on_roids/version'

Gem::Specification.new do |spec|
  spec.name          = "mongo_logs_on_roids"
  spec.version       = MongoLogsOnRoids::VERSION
  spec.authors       = ["thomas morgan"]
  spec.email         = ["tm@iprog.com"]

  spec.summary       = %q{Better logging for mongodb. Compatible w/Mongoid 5+, Rails, etc.}
  spec.description   = %q{Add color, DB time (Rails), etc to your mongo logs. Requires just mongo gem; compatible with Mongoid 5-7, Rails, etc.}
  spec.homepage      = "https://github.com/zarqman/mongo_logs_on_roids"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mongoid", ">= 5.1.1", "< 8"
  spec.add_development_dependency "rails", ">= 4.2", "< 6.2"
  spec.add_dependency "mongo", "~> 2.1"
end
