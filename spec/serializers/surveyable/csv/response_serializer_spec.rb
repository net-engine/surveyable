require 'spec_helper'

describe Surveyable::CSV::ResponseSerializer do
  let(:survey) { create(:survey) }
  let(:response) { create(:response, survey: survey) }
  let(:question1) { create(:question,
                           survey: survey,
                           content: "Banana",
                           field_type: "text_field") }
  let(:question2) { create(:question,
                           survey: survey,
                           content: "Apple",
                           field_type: "radio_button_field") }
  let(:answer1) { create(:answer,
                         question: question2,
                         content: 'good') }
  let(:answer2) { create(:answer,
                         question: question2,
                         content: 'great') }

  let!(:response_answer1) { create(:response_answer,
                                   response: response,
                                   question: question1,
                                   free_content: "Free content mate") }
  let!(:response_answer2) { create(:response_answer,
                                   response: response,
                                   question: question2,
                                   answer: answer1) }
  let!(:response_answer3) { create(:response_answer,
                                   response: response,
                                   question: question2,
                                   answer: answer2) }

  subject { described_class.new(response: response, question_ids: [question1.id, question2.id]) }

  describe "#to_csv" do
    it "returns answers" do
      subject.to_csv.should == "Testing,Free content mate,good;great\n"
    end
  end
end

