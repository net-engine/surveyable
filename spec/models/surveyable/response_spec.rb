require 'spec_helper'

module Surveyable
  describe Response do
    it { should belong_to(:survey) }
    it { should belong_to(:responseable) }
    it { should have_many(:response_answers) }
    it { should validate_presence_of(:survey) }

    describe "#generate_token" do
      let(:survey) { create(:survey) }

      it "creates token before create" do
        response = described_class.create(survey_id: survey.id)

        response.access_token.should_not be_blank
      end
    end
  end
end
