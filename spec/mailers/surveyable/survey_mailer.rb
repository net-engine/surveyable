require 'spec_helper'

describe Surveyable::SurveyMailer do
  let(:person) { create(:person) }
  let(:response) { create(:response, respondable: person) }

  describe "#invitation" do
    it "sends email to respondable" do
      mail = described_class.invitation(response)

      mail.subject.should == "You've been invited to respond #{response.survey.title}"
      mail.to.should == person.email
    end
  end
end
