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

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.13"
  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
end
