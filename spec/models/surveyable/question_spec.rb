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

    describe "#reportable?" do
      context "when field type is select_field" do
        it "returns true" do
          Surveyable::Question.new(field_type: 'select_field').should be_reportable
        end
      end

      context "when field type is radio_button_field" do
        it "returns true" do
          Surveyable::Question.new(field_type: 'radio_button_field').should be_reportable
        end
      end

      context "when field type is check_box_field" do
        it "returns true" do
          Surveyable::Question.new(field_type: 'check_box_field').should be_reportable
        end
      end

      context "when field type is text field" do
        it "returns false" do
          Surveyable::Question.new(field_type: 'text_field').should_not be_reportable
        end
      end

      context "when field type is text area field" do
        it "returns false" do
          Surveyable::Question.new(field_type: 'text_area_field').should_not be_reportable
        end
      end
    end

    describe "#reports" do
      context "when the question is not a reportable question" do
        let(:question) { create(:question, field_type: :text_field) }

        it "returns a 'N/A' string" do
          question.reports.should == 'N/A'
        end
      end

      context "when the question is reportable" do
        context "when no answers were provided yet" do
          let(:survey) { create(:survey_with_questions_and_answers, questions_count: 2) }
          let(:question) { survey.questions.first }

          it "returns an empty array" do
            question.reports.should == []
          end
        end

        context "when there was a provided response" do
          let!(:survey)   { create(:survey_with_questions_and_answers, questions_count: 1) }
          let!(:response) { create(:response, survey: survey) }
          let!(:question) { survey.questions.first }
          let!(:answer1) { question.answers.first }
          let!(:answer2) { question.answers.second }
          let!(:response_answer1) { response.response_answers.create(question: question, answer: answer1) }
          let!(:response_answer2) { response.response_answers.create(question: question, answer: answer2) }
          let!(:response_answer3) { response.response_answers.create(question: question, answer: answer2) }

          it "returns the correct result array" do
            expected = [
              { text: answer2.content, occurrence: 2, percentage: 66.67, id: answer2.id },
              { text: answer1.content, occurrence: 1, percentage: 33.33, id: answer1.id }
            ]

            question.reports.should == expected
          end
        end
      end
    end
  end
end
