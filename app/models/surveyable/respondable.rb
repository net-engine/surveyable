module Surveyable
  module Respondable
    extend ActiveSupport::Concern

    included do
      has_many :responses, as: :respondable, class_name: 'Surveyable::Response'
    end
  end
end
