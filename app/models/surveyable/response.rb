module Surveyable
  class Response < ActiveRecord::Base
    belongs_to :respondable, polymorphic: true
    belongs_to :respondent, polymorphic: true
    belongs_to :survey

    has_many :response_answers

    validates :access_token, :survey, presence: true

    before_validation :generate_token, on: :create

    scope :completed, ->{ where("completed_at IS NOT NULL") }
    scope :pending, ->{ where("completed_at IS NULL") }

    def completed?
      !!completed_at
    end

    def complete!
      update_attribute(:completed_at, Time.now)
    end

    def score
      response_answers.map(&:score).sum rescue 0
    end

    # TODO: Change moneywise references to .score to average_score
    def average_score
      dividor = response_answers.any? ? response_answers.count : 1

      (score.to_f / dividor).round
    end

    private

    def generate_token
      self.access_token = SecureRandom.uuid

      generate_token if Response.where(access_token: self.access_token).any?
    end
  end
end
