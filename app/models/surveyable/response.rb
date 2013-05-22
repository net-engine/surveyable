module Surveyable
  class Response < ActiveRecord::Base
    belongs_to :responseable, polymorphic: true
    belongs_to :survey

    has_many :response_answers

    validates :access_token, :survey, presence: true

    before_validation :generate_token, on: :create

    attr_accessible :survey_id

    private

    def generate_token
      self.access_token = SecureRandom.uuid

      generate_token if Response.where(access_token: self.access_token).any?
    end
  end
end
