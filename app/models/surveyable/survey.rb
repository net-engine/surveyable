module Surveyable
  class Survey < ActiveRecord::Base
    has_many :questions, dependent: :destroy
    has_many :responses, dependent: :destroy

    validates :title, presence: true

    scope :enabled, -> { where(enabled: true) }

    accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: lambda { |q| q[:title].blank? }

    def enable!
      update_attribute(:enabled, true)
    end

    def disable!
      update_attribute(:enabled, false)
    end

    def has_been_answered?
      self.responses.where('completed_at IS NOT NULL').count > 0
    end
  end
end
