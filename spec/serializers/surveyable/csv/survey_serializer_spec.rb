require 'spec_helper'

describe Surveyable::CSV::SurveySerializer do
  let(:survey) { create(:survey) }
  let(:response1) { create(:response,
                           survey: survey,
                           respondable: create(:person, name: "John")) }
  let(:response2) { create(:response,
                           survey: survey,
                           respondable: create(:person, name: "Mary")) }
  let(:question1) { create(:question,
                           survey: survey,
                           content: "Banana",
                           field_type: "text_field") }
  let(:question2) { create(:question,
                           survey: survey,
                           content: "Apple",
                           field_type: "radio_button_field") }
  let(:answer) { create(:answer,
                        question: question2,
                        content: 'good') }

  let!(:response_answer1) { create(:response_answer,
                                   response: response1,
                                   question: question1,
                                   free_content: "Free content mate") }
  let!(:response_answer2) { create(:response_answer,
                                   response: response1,
                                   question: question2,
                                   answer: answer) }

  let!(:response_answer3) { create(:response_answer,
                                   response: response2,
                                   question: question1,
                                   free_content: "Yeah no") }
  let!(:response_answer4) { create(:response_answer,
                                   response: response2,
                                   question: question2,
                                   answer: answer) }

  subject { described_class.new(object: survey, response_ids: [response1.id, response2.id]) }

  describe "#csv_headers" do
    it "returns headers" do
      subject.csv_headers.should == "Subject,Banana,Apple\n"
    end
  end

  describe "#to_csv" do
    it "returns answers" do
      subject.to_csv.should == "John,Free content mate,good\nMary,Yeah no,good\n"
    end
  end
end
