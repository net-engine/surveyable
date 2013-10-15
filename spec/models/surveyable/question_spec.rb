require 'spec_helper'

module Surveyable
  describe Question do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:field_type) }
    it { should belong_to(:survey) }
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:response_answers) }
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
      let!(:question) { create(:question, field_type: :text_field) }

      it "delegates to Report class" do
        Surveyable::Report.should_receive(:build).with(question: question)

        question.reports
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
          Surveyable::Question.new(field_type: 'text_field').should be_reportable
        end
      end

      context "when field type is text area field" do
        it "returns false" do
          Surveyable::Question.new(field_type: 'text_area_field').should_not be_reportable
        end
      end
    end

    describe "#potential_score" do
      context "when question is checkbox_field" do
        let(:question) { create(:question, field_type: :check_box_field) }
        let!(:answer1) { create(:answer, question: question, score: 1) }
        let!(:answer2) { create(:answer, question: question, score: 2) }

        it "returns sum of answers score" do
          question.potential_score.should == 3
        end
      end

      context "when question is not checkbox" do
        let(:question) { create(:question, field_type: :radio_button_field) }
        let!(:answer1) { create(:answer, question: question, score: 1) }
        let!(:answer2) { create(:answer, question: question, score: 2) }

        it "returns max answers score" do
          question.potential_score.should == 2
        end
      end
    end
  end
end
