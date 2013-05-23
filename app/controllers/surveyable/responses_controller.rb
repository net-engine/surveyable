module Surveyable
  class ResponsesController < ApplicationController
    layout 'surveys'

    def show
      @response = Response.where(access_token: params[:access_token]).first
      @survey   = @response.completed? ? nil : @response.survey
    end

    def create
      @response = Response.where(access_token: params[:access_token]).first
      ResponseHandler.handle(@response, params[:questions])
      @response.complete!
    end
  end
end
