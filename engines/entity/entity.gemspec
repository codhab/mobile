$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "entity/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "entity"
  s.version     = Entity::VERSION
  s.authors     = ["Elton Silva"]
  s.email       = ["elton.chrls@gmail.com"]
  s.homepage    = "https://github.com/codhab/mobile.git"
  s.summary     = "Summary of Entity."
  s.description = "Description of Entity."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.2"

  s.add_development_dependency "sqlite3"
end
