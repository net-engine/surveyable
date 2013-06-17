module Surveyable
  class Answer < ActiveRecord::Base
    acts_as_list scope: :question_id

    belongs_to :question

    validates :content, presence: true
    validates_numericality_of :score, only_integer: true, allow_nil: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100
  end
end
