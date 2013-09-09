module Surveyable
  class Report
    def self.build(options = {})
      new(options).build
    end

    attr_reader :question

    def initialize(options = {})
      @question = options[:question]
    end

    def build
      {
        field_type: question.field_type,
        answers: answers_with_occurences
      }
    end

    private

    def answers_with_occurences
      case question.field_type
      when "select_field", "radio_button_field", "check_box_field"
        set_occurences_through_answers
      when "rank_field"
        set_occurences_through_response_answers
      end
    end

    def set_occurences_through_answers
      [].tap do |distribution|
        question.answers.each do |answer|
          distribution << { answer_occurrence: answer.response_answers.count, answer_text: answer.content }
        end
      end
    end

    def set_occurences_through_response_answers
      [].tap do |distribution|
        count_occurences.each do |answer_text, answer_occurrence|
          distribution << { answer_occurrence: answer_occurrence, answer_text: answer_text }
        end
      end
    end

    def count_occurences
      question.response_answers.inject({}) do |hash, response_answer|
        hash[response_answer.free_content] ||= 0
        hash[response_answer.free_content] += 1
        hash
      end
    end
  end
end

