require 'spec_helper'

module Surveyable
  describe Survey do
    it { should validate_presence_of(:title) }
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:responses).dependent(:destroy) }
    it { should accept_nested_attributes_for(:questions).allow_destroy(true) }

    describe "#enabled" do
      let(:survey1) { create(:survey, enabled: true) }
      let(:survey2) { create(:survey, enabled: false) }

      it "returns enabled surveys" do
        described_class.enabled.should == [survey1]
      end
    end

    describe "#has_been_answered?" do
      let!(:survey) { create(:survey_with_questions_and_answers) }

      context "when it contains response with completed_at not null" do
        let!(:response) { create(:response, survey: survey, completed_at: Time.now) }

        it "returns true" do
          survey.has_been_answered?.should be_true
        end
      end

      context "when it contains response with completed_at not null" do
        it "returns false" do
          survey.has_been_answered?.should be_false
        end
      end
    end
  end
end
