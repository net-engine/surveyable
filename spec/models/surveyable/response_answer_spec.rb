require 'spec_helper'

module Surveyable
  describe ResponseAnswer do
    it { should belong_to(:response) }
    it { should belong_to(:question) }
    it { should belong_to(:answer) }
    it { should validate_presence_of(:response) }
    it { should validate_presence_of(:question) }

    describe "#score" do
      let(:survey) { create(:survey) }
      let(:question) { create(:question, survey: survey) }
      let(:answer) { create(:answer, question: question, score: 10) }
      let(:response) { create(:response, survey: survey) }

      context "when there is an answer" do
        let!(:response_answer) { create(:response_answer, response: response, question: question, answer: answer) }

        it "delegates to answer" do
          response_answer.score.should == 10
        end
      end

      context "when there is no answer" do
        let!(:response_answer) { create(:response_answer, response: response, question: question) }

        it "rescues zero" do
          response_answer.score.should == 0
        end
      end
    end
  end
end
