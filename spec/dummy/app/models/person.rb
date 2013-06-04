class Person < ActiveRecord::Base
  include Surveyable::Respondable
end
