module Surveyable
  class SurveysController < ApplicationController
    begin
      load_and_authorize_resource
    rescue
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
      @survey = Survey.new(params[:surveyable_survey])

      if @survey.save
        redirect_to surveyable_surveys_path, notice: 'Survey was successfully created.'
      else
        flash.now[:error] = @survey.errors.full_messages.join(', ')
        render :new
      end
    end

    def update
      if @survey.update_attributes(params[:surveyable_survey])
        redirect_to surveyable_surveys_path, notice: 'Survey was successfully updated.'
      else
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
  end
end
