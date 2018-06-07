$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "technical_assistance/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "technical_assistance"
  s.version     = TechnicalAssistance::VERSION
  s.authors     = ["Victor Vitalino"]
  s.email       = ["vitalino.victor@gmail.com"]
  s.homepage    = "http://www.codhab.df.gov.br"
  s.summary     = "Modulo da Assistência Técnica."
  s.description = "Modulo da Assistência Técnica para o aplicativo CODHAB."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.7"

  s.add_development_dependency "sqlite3"
end
