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

#### Make your class responseable by adding Surveyable::Responseable
    class User < ActiveRecord::Base
      include Surveyable::Responseable
    end

This adds has_many :responses to the user so that you can manage which survey is sent to the end user.

#### Add form to create responses to send to the responseable
    responseable_form_for(@user)

..whereas @user is the responseable.
