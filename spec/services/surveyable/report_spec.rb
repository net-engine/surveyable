require 'spec_helper'

describe Surveyable::Report do

  describe "#build" do
    context "when question is radio button field" do
      let!(:survey) { create(:survey) }
      let!(:question) { create(:question, field_type: 'radio_button_field', survey: survey) }
      let!(:answer1) { create(:answer, question: question, content: "Yes") }
      let!(:answer2) { create(:answer, question: question, content: "No") }
      let!(:response) { create(:response, survey: survey) }

      let!(:response_answer1) { response.response_answers.create(question: question, answer: answer1) }
      let!(:response_answer2) { response.response_answers.create(question: question, answer: answer2) }
      let!(:response_answer3) { response.response_answers.create(question: question, answer: answer2) }

      it "returns hash" do
        expected = {
          field_type: 'radio_button_field',
          answers: [
            { answer_occurrence: 1, answer_text: answer1.content },
            { answer_occurrence: 2, answer_text: answer2.content }
          ]
        }

        Surveyable::Report.build(question: question).should == expected
      end
    end

    context "when question is rank field" do
      let!(:survey) { create(:survey) }
      let!(:question) { create(:question, field_type: 'rank_field', minimum: 1, maximum: 10, survey: survey) }
      let!(:response) { create(:response, survey: survey) }

      let!(:response_answer1) { response.response_answers.create(question: question, free_content: '2') }
      let!(:response_answer2) { response.response_answers.create(question: question, free_content: '2') }
      let!(:response_answer3) { response.response_answers.create(question: question, free_content: '8') }

      it "returns hash" do
        expected = {
          field_type: 'rank_field',
          answers: [
            { answer_occurrence: 2, answer_text: '2' },
            { answer_occurrence: 1, answer_text: '8' }
          ]
        }

        Surveyable::Report.build(question: question).should == expected
      end
    end
  end
end
