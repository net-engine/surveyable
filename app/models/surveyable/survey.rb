module Surveyable
  class Survey < ActiveRecord::Base
    has_many :questions, dependent: :destroy, order: :position
    has_many :answers, through: :questions
    has_many :responses, dependent: :destroy
    has_many :response_answers, through: :responses

    validates :title, presence: true

    scope :enabled, -> { where(enabled: true) }

    accepts_nested_attributes_for :questions, allow_destroy: true, reject_if: lambda { |q| q[:content].blank? }


    def enable!
      update_attribute(:enabled, true)
    end

    def disable!
      update_attribute(:enabled, false)
    end

    def has_been_answered?
      false#self.responses.where('completed_at IS NOT NULL').count > 0
    end

    def potential_score
      self.questions.map(&:potential_score).compact.sum
    end

    def average_score
      dividor = self.responses.completed.any? ? self.responses.completed.count.to_f : 1

      (self.responses.completed.map(&:score).sum.to_f / dividor).round(2)
    end
  end
end
