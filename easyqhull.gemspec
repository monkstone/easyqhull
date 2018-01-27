# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easyqhull/version'

Gem::Specification.new do |spec|
  spec.name = 'easyqhull'
  spec.version = EasyQHull::VERSION
  spec.has_rdoc = true
  spec.extra_rdoc_files = %w{README.md LICENSE}
  spec.summary = %q{Updated and extended EasyQHull library for JRubyArt and propane}
  spec.description =<<-EOS
  EasyQHull library wrapped in a rubygem. Compiled and tested with JRubyArt-1.4.5 and processing-3.6
  EOS
  spec.licenses = %w{Apache-2.0}
  spec.authors = %w{Martin\ Prout}
  spec.email = 'mamba2928@yahoo.co.uk'
  spec.homepage = 'http://ruby-processing.github.io/EasyQHull/'
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files << 'lib/easyqhull.jar'
  spec.require_paths = ['lib']
  spec.add_development_dependency 'rake', '~> 12', '>= 12.0'
  spec.platform = 'java'
  spec.requirements << 'A decent graphics card'
  spec.requirements << 'java runtime >= 1.8+'
  spec.requirements << 'processing = 3.3.6+'
end
