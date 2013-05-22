module Surveyable
  class V1::SurveySerializer < V1::BaseSerializer
    attributes :id, :title, :enabled

    has_many :questions, serializer: Surveyable::V1::QuestionSerializer
  end
end

