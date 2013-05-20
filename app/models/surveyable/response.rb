module Surveyable
  class Response < ActiveRecord::Base
    belongs_to :responseable, polymorphic: true
    belongs_to :survey

    has_many :response_answers
  end
end
