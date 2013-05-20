module Surveyable
  class ResponseAnswer < ActiveRecord::Base
    belongs_to :response
    belongs_to :question
    belongs_to :answer

    validates :response, presence: true
    validates :question, presence: true
  end
end
