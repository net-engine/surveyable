module Surveyable
  class Survey < ActiveRecord::Base
    validates :title, presence: true

    has_many :questions

    attr_accessible :enabled, :title
  end
end
