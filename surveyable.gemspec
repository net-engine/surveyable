$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "surveyable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "surveyable"
  s.version     = Surveyable::VERSION
  s.authors     = ["NetEngine"]
  s.email       = ["info@netengine.com.au"]
  s.homepage    = "http://netengine.com.au"
  s.summary     = "Surveying your application made easy"
  s.description = "Easy to create surveys"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "strong_parameters", "~> 0.2.1"
  s.add_dependency "haml"
  s.add_dependency "acts_as_list"
end
