module Surveyable
  class Report
    def self.build(options = {})
      new(options).build
    end

    attr_reader :question, :current_user, :filters

    def initialize(options = {})
      @question     = options[:question]
      @current_user = options[:current_user]
      @filters      = options[:filters] || {}
    end

    def build
      { field_type: question.field_type,
        answers: answers_with_occurences }
    end

    private

    def answers_with_occurences
      case question.field_type
      when "select_field", "radio_button_field", "check_box_field"
        set_occurences_through_answers
      when "rank_field"
        set_occurences_through_response_answers
      else
        []
      end
    end

    def set_occurences_through_answers
      [].tap do |distribution|
        question.answers.each do |answer|
          answer_occurrence = Surveyable::ResponseAnswer.where(response_id: response_ids, answer_id: answer.id).count

          distribution << { answer_occurrence: answer_occurrence, answer_text: answer.content }
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
      possible_results = Hash[(question.minimum..question.maximum).map { |i| [i.to_s, 0] }]

      response_answers = Surveyable::ResponseAnswer.where(response_id: response_ids, question_id: question.id)

      response_answers.each do |response_answer|
        possible_results[response_answer.free_content] += 1
      end

      possible_results
    end

    def response_ids
      @response_ids ||= Surveyable::Response.where(visible_respondable_args).pluck(:id).uniq
    end

    def visible_respondable_args
      Surveyable.report_filter_class.filter(filters.merge(current_user: current_user))
    end
  end
end

