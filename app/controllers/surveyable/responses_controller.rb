module Surveyable
  class ResponsesController < ::Surveyable::ApplicationController
    def index
      @responses = Response.all
    end

    def create
      @response = Response.new(params[:surveyable_response])

      if @response.save
        flash[:notice] = "Response was succesfully created"
      else
        flash[:error] = @response.errors.full_messages.join(", ")
      end

      redirect_to :back
    end

    def show
      @response = Response.find(params[:id])
    end

    def destroy
      @response = Response.find(params[:id])
      @response.destroy

      redirect_to :back
    end
  end
end
