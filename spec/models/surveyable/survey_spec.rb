require 'spec_helper'

module Surveyable
  describe Survey do
    it { should validate_presence_of(:title) }
    it { should have_many(:questions).dependent(:destroy) }
    it { should have_many(:responses).dependent(:destroy) }
    it { should accept_nested_attributes_for(:questions).allow_destroy(true) }

    %w( title enabled questions_attributes ).each do |attr|
      it { should allow_mass_assignment_of(attr.to_sym) }
    end

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

    describe "#enable!" do
      let(:survey) { create(:survey, enabled: false) }

      it "changes survey status to enabled" do
        survey.enable!
        survey.should be_enabled
      end
    end

    describe "#disable!" do
      let(:survey) { create(:survey, enabled: true) }

      it "changes survey status to disabled" do
        survey.disable!
        survey.should_not be_enabled
      end
    end
  end
end
