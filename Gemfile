source "http://rubygems.org"

# Declare your gem's dependencies in surveyable.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"

group :development, :test do
  gem 'haml-rails'
  gem 'debugger'
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl'
end

group :test do
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'poltergeist'
  gem 'database_cleaner'
  gem 'launchy'
end

