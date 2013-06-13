require 'spec_helper'

describe Surveyable::ResponsesController do
  before { request.env["HTTP_REFERER"] = 'http://example.com' }

  let(:person) { create(:person) }
  let(:survey) { create(:survey) }
  let(:params) { { surveyable_response: { survey_id: survey.id, respondable_id: person.id, respondable_type: person.class.to_s } } }

  describe "GET create" do
    it "creates response" do
      expect {
        post :create, params
      }.to change(Surveyable::Response, :count).by(1)
    end

    it "redirects back" do
      post :create, params
      response.should redirect_to :back
    end

    it "sets flash notice" do
      post :create, params
      flash[:notice].should == "Response was succesfully created"
    end

    context "when email survey is present" do
      it "emails respondable" do
        Surveyable::SurveyMailer.should_receive(:invitation).with(kind_of(Surveyable::Response), person.email).and_return(mock(deliver: true))
        post :create, params.merge({ email_survey: true })
      end

      it "redirects back" do
        post :create, params.merge({ email_survey: true })
        response.should redirect_to :back
      end
    end

    context "when answer survey is present" do
      it "redirects to answer survey" do
        post :create, params.merge({ answer_survey: true })
        response.should redirect_to response_survey_url(Surveyable::Response.last.access_token)
      end
    end
  end
end

