class Person < ActiveRecord::Base
  include Surveyable::Responseable

  attr_accessible :name
end
