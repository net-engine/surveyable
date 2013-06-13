module Surveyable
  class ResponsesController < ::Surveyable::ApplicationController
    def create
      @response = Response.new(response_attributes)

      if @response.save
        flash[:notice] = "Response was succesfully created"

        if params.has_key?(:email_survey)
          Surveyable::SurveyMailer.invitation(@response, @response.respondable.email).deliver
        elsif params.has_key?(:answer_survey)
          redirect_to response_survey_url(@response.access_token) and return
        end
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
      params.require(:surveyable_response).permit(:survey_id, :respondable_id, :respondable_type)
    end
  end
end
