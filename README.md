# Surveyable

Add survey to your application made easy.

### Running tests

    rake app:db:drop:all app:db:create:all app:db:migrate app:db:test:prepare
    rspec spec

### Installing into your application

##### Add migrations
    rake surveyable_engine:install:migrations

#### Include into your application.js
    //= require surveyable/application

#### Create config/initializers/surveyable.rb if you want to change defaults
    Surveyable.application_controller_class = 'ApplicationController' (default to ActionController::Base)
    Surveyable.responseable_class = 'Admin' (default to User) # which entity from your system should respond to surveys

