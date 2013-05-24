module Surveyable
  class ResponseAnswer < ActiveRecord::Base
    belongs_to :response
    belongs_to :question
    belongs_to :answer

    validates :response, presence: true
    validates :question, presence: true

    attr_accessible :question_id, :answer_id, :free_content
  end
end
