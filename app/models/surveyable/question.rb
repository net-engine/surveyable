module Surveyable
  class Question < ActiveRecord::Base
    has_many :answers, dependent: :destroy
    belongs_to :survey

    validates :content, :field_type, presence: true
  end
end
