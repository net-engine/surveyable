require 'spec_helper'

describe Surveyable::RespondableController do
  let(:person) { create(:person) }
  let(:response) { create(:response, respondable: person) }

  describe "#complete" do
    context "when response has already been completed" do
      before { response.complete! }

      it "redirects to show" do
        post :complete, access_token: response.access_token

        response.should redirect_to response_survey_path(response.access_token)
      end
    end
  end
end
