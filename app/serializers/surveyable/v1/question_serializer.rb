module Surveyable
  class V1::QuestionSerializer < V1::BaseSerializer
    attributes :id, :content, :field_type, :required

    has_many :answers, serializer: V1::AnswerSerializer
  end
end

