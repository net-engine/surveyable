module Surveyable
  class Survey < ActiveRecord::Base
    validates :title, presence: true

    attr_accessible :enabled, :title
  end
end
