require_dependency "surveyable/application_controller"

module Surveyable
  class SurveysController < ApplicationController
    def index
      @surveys = Survey.enabled
    end

    def new
      @survey = Survey.new

      3.times do
        question = @survey.questions.build
        4.times { question.answers.build }
      end
    end

    def create
      @survey = Survey.new(params[:survey])

      if @survey.save
        render json: @survey, status: 200, notice: 'Survey created successfully.'
      else
        render json: @survey.errors, status: 400
      end
    end

    def edit
      @survey = Survey.find(params[:id])
      redirect_to admin_surveys_path, warning: 'Cannot update this survey' and return if @survey.has_been_answered?
    end

    def update
      @survey = Survey.find(params[:id])
      redirect_to admin_surveys_path, warning: 'Cannot update this survey' and return if @survey.has_been_answered?

      if @survey.update_attributes(params[:survey])
        redirect_to admin_surveys_path, notice: 'Survey updated successfully.'
      else
        render :edit
      end
    end

    def show
      @survey = Survey.find(params[:id])
    end

    def destroy
      @survey = Survey.find(params[:id])
      @survey.update_attribute(:enabled, false)
      redirect_to admin_surveys_path, notice: 'Survey deleted successfully.'
    end
  end
end
