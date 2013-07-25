require 'spec_helper'

describe Surveyable::ResponsesController do
  before { request.env["HTTP_REFERER"] = 'http://example.com' }

  let(:person) { create(:person) }
  let(:survey) { create(:survey) }
  let(:params) { { surveyable_response: { survey_id: survey.id, respondable_id: person.id, respondable_type: person.class.to_s } } }

  describe "POST create" do
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
  end
end

