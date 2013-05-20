module Surveyable
  class Question < ActiveRecord::Base
    belongs_to :survey

    validates :title, :field_type, presence: true

    attr_accessible :field_type, :required, :title
  end
end
