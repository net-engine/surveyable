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
        question = response.survey.questions.find(question_id)

        case question.field_type.to_sym
        when :select_field, :radio_button_field, :check_box_field
          create_multiple_choice_answer(question.id, values)
        when :text_field, :text_area_field, :date_field
          create_text_answer(question.id, values)
        end
      end
    end

    private

    def create_text_answer(question_id, value)
      attributes = { question_id: question_id, free_content: value }
      response.response_answers.create(attributes)
    end

    def create_multiple_choice_answer(question_id, values)
      values.split.flatten.each do |value|
        attributes = { question_id: question_id, answer_id: value }
        response.response_answers.create(attributes)
      end
    end
  end
end
