require_dependency "surveyable/application_controller"

module Surveyable
  class Api::V1::SurveysController < ApplicationController
    respond_to :json

    before_filter :fetch_survey, only: [:update, :show, :destroy]

    def index
      @surveys = Survey.enabled
      respond_with @surveys, each_serializer: V1::SurveySerializer
    end

    def create
      @survey = Survey.new(params[:survey])
      @survey.save

      respond_with @survey, location: surveyable_url, serializer: V1::SurveySerializer
    end

    def update
      @survey.update_attributes(params[:survey])

      respond_with @survey, serializer: V1::SurveySerializer
    end

    def show
      respond_with @survey, serializer: V1::SurveySerializer
    end

    def destroy
      @survey.disable!

      respond_with @survey, serializer: V1::SurveySerializer
    end

    private

    def fetch_survey
      @survey = Survey.find(params[:id])
    end
  end
end
