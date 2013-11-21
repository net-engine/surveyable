module Surveyable
  class QuestionsController < ::Surveyable::ApplicationController
    before_filter :fetch_question

    def reports
      render json: Surveyable::Report.build(question: @question, current_user: current_user, filters: params[:filters])
    end

    private

    def fetch_question
      @question = Question.find(params[:id])
    end
  end
end

