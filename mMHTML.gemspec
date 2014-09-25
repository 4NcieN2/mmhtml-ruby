# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mMHTML/version'

Gem::Specification.new do |spec|
  spec.name          = "mMHTML"
  spec.version       = MMHTML::VERSION
  spec.authors       = ["Roman Solomud"]
  spec.email         = ["romaslmd@gmail.com"]
  spec.summary       = %q{This gem provides usage of MIME-HTML files (generate or parse)}
  spec.description   = %q{Gives ability to work with mime-html files. Parse, retrieve components or generate from file or uri}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end