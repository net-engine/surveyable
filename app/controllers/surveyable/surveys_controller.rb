module Surveyable
  class SurveysController < ApplicationController
    begin
      load_and_authorize_resource
    rescue NameError
      before_filter :fetch_survey, only: [:edit, :update, :destroy]
    end

    before_filter :allow_to_edit, only: [:edit, :update]

    def index
      @surveys = Survey.where(enabled: true)
    end

    def new
      @survey = Survey.new

      3.times do
        question = @survey.questions.build
        4.times { question.answers.build }
      end
    end

    def create
      @survey = Survey.new(survey_attributes)

      if @survey.save
        redirect_to surveyable_surveys_path, notice: 'Survey was successfully created.'
      else
        flash.now[:error] = @survey.errors.full_messages.join(', ')
        render :new
      end
    end

    def update
      if @survey.update_attributes(survey_attributes)
        redirect_to surveyable_surveys_path, notice: 'Survey was successfully updated.'
      else
        flash.now[:error] = @survey.errors.full_messages.join(', ')
        render :edit
      end
    end

    def destroy
      @survey.disable!

      redirect_to surveyable_surveys_path, notice: 'Survey was successfully deleted.'
    end

    private

    def fetch_survey
      @survey = Survey.find(params[:id])
    end

    def allow_to_edit
      redirect_to surveyable_surveys_path, warning: 'Cannot update this survey' and return if @survey.has_been_answered?
    end

    def survey_attributes
      answers_attributes = [:position, :content, :id, :_destroy]
      questions_attributes = [:content, :field_type, :required, :id, :_destroy,
                              answers_attributes: answers_attributes]

      params.require(:surveyable_survey).
        permit(:title, :enabled, questions_attributes: questions_attributes)
    end
  end
end
