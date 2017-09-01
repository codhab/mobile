$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "social/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "social"
  s.version     = Social::VERSION
  s.authors     = ["Victor Vitalino"]
  s.email       = ["vitalino.victor@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of Social."
  s.description = "Description of Social."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.5"

  s.add_development_dependency "sqlite3"
end
