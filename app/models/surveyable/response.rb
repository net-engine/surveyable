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

    private

    def generate_token
      self.access_token = SecureRandom.uuid

      generate_token if Response.where(access_token: self.access_token).any?
    end

    # This private method provides a data structure as per below :
    # { answer_id1: [score_response_answer1, score_response_answer2], answer_id2: ... }
    # we don't want to add two scores of two answers for a same question (checkboxes case).
    # Hence we group them by question, to average them later
    def grouped_scored_ra
      scored_ra     = 
      g_scored_ra   = {}
      scored_ra.each do |ra|
        g_scored_ra[ra.question.id] = [] unless g_scored_ra[ra.question.id]
        g_scored_ra[ra.question.id] << ra.answer.score
      end
      return g_scored_ra
    end
  end
end
