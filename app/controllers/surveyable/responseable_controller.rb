module Surveyable
  class ResponseableController < ApplicationController
    layout 'responseable'

    def show
      @response = Response.where(access_token: params[:access_token]).first
      @survey   = @response.completed? ? nil : @response.survey
    end

    def complete
      @response = Response.where(access_token: params[:access_token]).first
      ResponseHandler.handle(@response, params[:questions])
      @response.complete!
    end
  end
end

