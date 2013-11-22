class Person < ActiveRecord::Base
  include Surveyable::Respondable

  def to_s
    name
  end
end
