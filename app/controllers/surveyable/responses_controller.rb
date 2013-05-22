module Surveyable
  class ResponsesController < ApplicationController
    layout 'surveys'

    def show
      @response = Response.where(access_token: params[:access_token]).first
      @survey   = @response.completed? ? nil : @response.survey
    end
  end
end
