module Surveyable
  class ResponseAnswersController < ::Surveyable::ApplicationController
    before_filter :fetch_question

    def index
      @response_answers = Surveyable::ResponseAnswer.where(response_id: response_ids, question_id: @question.id)

      respond_to do |format|
        format.js
      end
    end

    private

    def fetch_question
      @question = Question.find(params[:question_id])
    end

    def response_ids
      Surveyable::Response.where(visible_respondable_args).pluck(:id).uniq
    end

    def visible_respondable_args
      filters = params.fetch(:filter, {})
      Surveyable.report_filter_class.filter(filters.merge(current_user: current_user))
    end
  end
end

