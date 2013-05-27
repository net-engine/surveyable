module Surveyable
  class Answer < ActiveRecord::Base
    acts_as_list scope: :question_id

    belongs_to :question

    validates :content, presence: true
  end
end
