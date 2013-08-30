module Surveyable
  class QuestionsController < ::Surveyable::ApplicationController
    begin
      load_and_authorize_resource
    rescue NameError
      before_filter :fetch_question, only: :reports
    end

    def reports
      render json: @question.reports
    end

    private

    def fetch_question
      @question = Question.find(params[:id])
    end
  end
end