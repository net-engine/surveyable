require 'spec_helper'

describe Surveyable::ResponseHandler do
  let(:survey) { create(:survey) }
  let(:response) { create(:response, survey: survey) }

  describe ".handle" do
    context "when question is text field" do
      let!(:question) { create(:question, field_type: :text_field, survey: survey) }
      let(:params_questions) { { question.id => "free content answer" } }

      it "creates response answers" do
        described_class.handle(response, params_questions)

        response.response_answers.count.should == 1
        response.response_answers.first.free_content.should == 'free content answer'
        response.response_answers.first.answer_id.should be_nil
      end
    end

    context "when question is check box field" do
      let!(:question) { create(:question_with_answers,
                               answers_count: 2,
                               field_type: :check_box_field,
                               survey: survey) }

      let(:params_questions) { { question.id => question.answers.first.id.to_s } }

      it "creates response answers" do
        described_class.handle(response, params_questions)

        response.reload.response_answers.count.should == 1
        response.response_answers.first.answer_id.should == question.answers.first.id
        response.response_answers.first.free_content.should be_nil
      end
    end
  end
end
