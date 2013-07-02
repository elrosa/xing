# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "xing/version"

Gem::Specification.new do |gem|
  gem.name        = "xing"
  gem.version     = Xing::VERSION
  gem.authors     = ["Magdalena Sikorska"]
  gem.email       = ["madzia.sikorska@gmail.com"]
  gem.homepage    = 'http://github.com/elrosa/xing'
  gem.summary     = %q{Ruby wrapper for Xing API}
  gem.description = gem.summary

  gem.rubyforge_project = "xing"

  gem.files = `git ls-files`.split("\n")
  gem.require_paths = ['lib']
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.add_dependency 'hashie', '~> 1.2.0'
  gem.add_dependency 'multi_json', '>= 1.3.6'
  gem.add_dependency 'oauth', '~> 0.4.5'
  
  gem.add_development_dependency 'json', '~> 1.6'
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rdoc', '~> 3.8'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'webmock', '~> 1.8.7'
  gem.add_development_dependency 'guard-rspec', '~> 3.0.0'

end
