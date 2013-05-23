module Surveyable
  class Answer < ActiveRecord::Base
    belongs_to :question

    validates :content, presence: true

    attr_accessible :content, :position, :question
  end
end
