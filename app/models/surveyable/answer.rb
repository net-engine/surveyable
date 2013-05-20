module Surveyable
  class Answer < ActiveRecord::Base
    belongs_to :question

    validates :question_id, :content, presence: true

    attr_accessible :content, :position
  end
end
