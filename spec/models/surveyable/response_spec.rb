require 'spec_helper'

module Surveyable
  describe Response do
    it { should belong_to(:survey) }
    it { should belong_to(:respondable) }
    it { should belong_to(:respondent) }
    it { should have_many(:response_answers) }
    it { should validate_presence_of(:survey) }

    describe "#generate_token" do
      let(:survey) { create(:survey) }

      it "creates token before create" do
        response = described_class.create(survey: survey)

        response.access_token.should_not be_blank
      end
    end

    describe "#completed?" do
      context "when completed_at is null" do
        let(:response) { build_stubbed(:response, completed_at: nil) }

        it "returns false" do
          response.should_not be_completed
        end
      end

      context "when completed_at is not null" do
        let(:response) { build_stubbed(:response, completed_at: Time.now) }

        it "returns true" do
          response.should be_completed
        end
      end
    end

    describe "#complete!" do
      let(:response) { create(:response) }

      it "sets completed_at" do
        response.complete!
        response.should be_completed
      end
    end

    describe ".completed" do
      let(:response1) { create(:response, completed_at: nil) }
      let(:response2) { create(:response, completed_at: Time.now) }

      it "returns only completed surveys" do
        described_class.completed.should == [response2]
      end
    end

    describe "#score" do
      context "when there are two answers for a first question and one answer for a second question" do
        let(:survey)   { create(:survey_with_questions_and_answers) }
        let(:response) { create(:response, survey: survey) }
        let(:ra1)      { { response: response, question: survey.questions.first, answer: survey.questions.first.answers.first } }
        let(:ra2)      { { response: response, question: survey.questions.first, answer: survey.questions.first.answers[1] } }
        let(:ra3)      { { response: response, question: survey.questions[1],    answer: survey.questions[1].answers.first } }

        before do
          response.response_answers.create(ra1)
          response.response_answers.create(ra2)
          response.response_answers.create(ra3)
        end

        it "sets the score properly" do
          answer1 = survey.questions.first.answers.first
          answer2 = survey.questions.first.answers[1]
          answer3 = survey.questions[1].answers.first
          answer1.score = 30
          answer2.score = 70
          answer3.score = 100
          [answer1, answer2, answer3].map(&:save)
          # ((30 + 70) / 2) + 100) / 2
          response.reload.score.should == 75
        end
      end

      context "when there are no score for this response" do
        let(:survey)   { create(:survey_with_questions_and_answers) }
        let(:response) { create(:response, survey: survey) }

        it "returns No Score" do
          response.score.should == "No Score"
        end
      end
    end

    describe ".pending" do
      let(:response1) { create(:response, completed_at: nil) }
      let(:response2) { create(:response, completed_at: Time.now) }

      it "returns only pending surveys" do
        described_class.pending.should == [response1]
      end
    end
  end
end
