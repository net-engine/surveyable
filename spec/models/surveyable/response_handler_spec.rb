require 'spec_helper'

describe Surveyable::ResponseHandler do
  let(:survey) { create(:survey_with_questions_and_answers) }
  let(:response) { create(:response, survey: survey) }
  let(:params_questions) {
    {
      survey.questions.first.id => survey.questions.first.answers.first.id,
      survey.questions.last.id => survey.questions.last.answers.last.id
    }
  }

  describe ".handle" do
    it "creates response answers" do
      described_class.handle(response, params_questions)

      response.reload.response_answers.count.should == 2
    end
  end
end
