module Surveyable
  class ResponsesController < ::Surveyable::ApplicationController
    def create
      @response = Response.new(response_attributes)

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

    private

    def response_attributes
      params.require(:surveyable_response).permit(:survey_id, :respondable_id, :respondable_type, :respondent_type, :respondent_id)
    end
  end
end
