module Surveyable
  class ResponseHandler
    def self.handle(response, questions)
      new(response, questions).handle
    end

    attr_reader :response, :questions

    def initialize(response, questions)
      @response  = response
      @questions = questions
    end

    def handle
      questions.each do |question_id, values|
        values   = values.split.flatten
        question = response.survey.questions.find(question_id)

        values.each do |value|
          attributes = { question_id: question.id }

          case question.field_type.to_sym
          when :select_field, :radio_button_field, :check_box_field
            attributes.merge!(answer_id: value)
          when :text_field, :text_area_field, :date_field
            attributes.merge!(free_content: value)
          end

          response.response_answers.create(attributes)
        end
      end
    end
  end
end
