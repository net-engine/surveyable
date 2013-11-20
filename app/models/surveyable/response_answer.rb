module Surveyable
  class ResponseAnswer < ActiveRecord::Base
    belongs_to :response
    belongs_to :question
    belongs_to :answer

    validates :response, presence: true
    validates :question, presence: true

    def score
      answer.score rescue 0
    end

    def to_s
      question.text_answer? ? free_content : answer.content
    end
  end
end
