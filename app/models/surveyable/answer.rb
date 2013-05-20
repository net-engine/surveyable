module Surveyable
  class Answer < ActiveRecord::Base
    belongs_to :question

    validates :question_id, :content, presence: true
  end
end
