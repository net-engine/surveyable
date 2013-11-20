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

    describe "#to_s" do
      let(:survey) { create(:survey) }
      let(:response) { create(:response, survey: survey) }

      context "for text answers question" do
        let(:question) { create(:question, survey: survey, field_type: "text_field") }
        let(:response_answer) { create(:response_answer, question: question, response: response, free_content: "Free content mate") }

        it "returns free content text" do
          response_answer.to_s.should == "Free content mate"
        end
      end

      context "for not text answers question" do
        let(:question) { create(:question, survey: survey, field_type: "radio_button_field") }
        let(:answer) { create(:answer, question: question, content: 'good') }
        let(:response_answer) { create(:response_answer, response: response, question: question, answer: answer) }

        it "returns free content text" do
          response_answer.to_s.should == 'good'
        end
      end

    end
  end
end
