$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "healty/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "healty"
  s.version     = Healty::VERSION
  s.authors     = ["Igor Marques"]
  s.email       = ["igormarjes@gmail.com"]
  s.homepage    = ""
  s.summary     = "Summary of Healty."
  s.description = "Description of Healty."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.6"

  s.add_development_dependency "sqlite3"
end
