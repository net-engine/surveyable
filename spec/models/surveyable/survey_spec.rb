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
          pending 'Disabled temporarely'
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

    describe "#potential_score" do
      let!(:survey) { create(:survey) }
      let!(:question1) { create(:question, survey: survey) }
      let!(:question2) { create(:question, survey: survey) }

      before do
        Surveyable::Question.any_instance.stub(:potential_score).and_return(8)
      end

      it "sums up questions potential scores" do
        survey.potential_score.should == 16
      end
    end

    describe "#average_score" do
      let!(:survey) { create(:survey) }
      let!(:response1) { create(:response, survey: survey) }
      let!(:response2) { create(:response, survey: survey) }

      before do
        Surveyable::Response.any_instance.stub(:score).and_return(8)
      end


      it "returns sum of responses scores" do
        survey.average_score.should == 8
      end
    end
  end
end
