require 'spec_helper'

module Surveyable
  describe Question do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:field_type) }
    it { should belong_to(:survey) }
    it { should have_many(:answers).dependent(:destroy) }
    it { should accept_nested_attributes_for(:answers).allow_destroy(true) }

    describe "validations" do
      context "when rank field" do
        let(:question) { build(:question, field_type: :rank_field, minimum: 1, maximum: 10) }
        it { question.should validate_presence_of(:maximum) }
        it { question.should validate_presence_of(:minimum) }

        it "doesn't allow minimum to be greater than maximum" do
          question = build(:question, field_type: :rank_field, minimum: 10, maximum: 1)
          question.valid?
          question.errors[:maximum].should == ['Maximum must be greater than minimum']
        end
      end
    end

    describe "#reports" do
      context "when the question is not a reportable question" do
        let!(:question){ create(:question) }
        it "should return a 'N/A' string" do
          question.reportable_question?.should == false
          question.reports.should == 'N/A'
        end
      end

      context "when the question is reportable but there was no response provided for that survey" do
        let!(:survey){ create(:survey_with_questions_and_answers, questions_count: 2) }
        it "should return an empty array" do
          question = survey.questions.first
          question.reportable_question?.should == true
          ResponseAnswer.where(question_id: question.id).should be_empty
          question.reports.should == []
        end
      end

      context "when the question is reportable and where there was a provided response" do
        let!(:survey)   { create(:survey_with_questions_and_answers, questions_count: 1) }
        let!(:response) { create(:response, survey: survey) }
        let!(:ra1)      { { response: response, question: survey.questions.first, answer: survey.questions.first.answers.first } }
        let!(:ra2)      { { response: response, question: survey.questions.first, answer: survey.questions.first.answers[1] } }
        let!(:ra3)      { { response: response, question: survey.questions.first, answer: survey.questions.first.answers[1] } }

        before do
          response.response_answers.create(ra1)
          response.response_answers.create(ra2)
          response.response_answers.create(ra3)
        end

        it "should return the correct result array" do
          question = survey.questions.first
          question.reportable_question?.should == true
          ResponseAnswer.where(question_id: question.id).should_not be_empty
          question.reports.should == [
            # 2/3
            {:text=>survey.questions.first.answers[1].content, :occurrence=>2, :percentage=>66.67, :id=>survey.questions.first.answers[1].id},
            # 1/3
            {:text=>survey.questions.first.answers[0].content, :occurrence=>1, :percentage=>33.33, :id=>survey.questions.first.answers[0].id}]
        end
      end
    end
  end
end
