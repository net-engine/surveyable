module Surveyable
  class ResponseAnswersController < ::Surveyable::ApplicationController
    before_filter :fetch_question

    def index
      @response_answers = Surveyable::ResponseAnswer.where(response_id: visible_response_ids, question_id: @question.id)

      respond_to do |format|
        format.js
      end
    end

    private

    def fetch_question
      @question = Question.find(params[:question_id])
    end
  end
end

