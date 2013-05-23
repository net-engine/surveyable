module Surveyable
  class SurveysController < ApplicationController
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
        redirect_to surveyable_surveys_path, notice: 'Survey created successfully.'
      else
        flash.now[:error] = @survey.errors.full_messages.join(', ')
        render :new
      end
    end

    def edit
      @survey = Survey.find(params[:id])

      redirect_to surveyable_surveys_path, warning: 'Cannot update this survey' and return if @survey.has_been_answered?
    end

    def update
      @survey = Survey.find(params[:id])
      redirect_to surveyable_surveys_path, warning: 'Cannot update this survey' and return if @survey.has_been_answered?

      if @survey.update_attributes(params[:surveyable_survey])
        redirect_to surveyable_survey_path, notice: 'Survey updated successfully.'
      else
        render :edit
      end
    end

    def show
      @survey = Survey.find(params[:id])
    end

    def destroy
      @survey = Survey.find(params[:id])
      @survey.disable!

      redirect_to surveyable_surveys_path, notice: 'Survey deleted successfully.'
    end
  end
end
