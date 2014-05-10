# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'faux_crop/version'

Gem::Specification.new do |spec|
  spec.name          = "faux_crop"
  spec.version       = FauxCrop::VERSION
  spec.authors       = ["Fernando Sainz"]
  spec.email         = ["info@fsainz.com"]
  spec.description   = %q{Rails helper for faux cropping with CSS}
  spec.summary       = %q{Adds the necessary wrappers in order to show only a given part of an image as if it had been cropped.}
  spec.homepage      = "http://fsainz.com/rails_helper_faux_crop.html"
  spec.license       = "Feel free to do whatever you like."

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
