module Surveyable
  module Responseable
    extend ActiveSupport::Concern

    included do
      has_many :responses, as: :responseable, class_name: 'Surveyable::Response'
    end
  end
end

