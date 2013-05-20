source "http://rubygems.org"

# Declare your gem's dependencies in surveyable.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"
gem "active_model_serializers", '~> 0.8.0'

group :development, :test do
  gem 'debugger'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl'
end

group :test do
  gem 'shoulda-matchers'
end

