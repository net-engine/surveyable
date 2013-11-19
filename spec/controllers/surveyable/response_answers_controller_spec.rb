require "spec_helper"

describe Surveyable::ResponseAnswersController do
  let(:survey) { create(:survey_with_questions_and_answers) }
  let(:question) { survey.questions.first }

  describe "GET index" do
    it "responds to js" do
      get :index, question_id: question.id, format: :js

      response.should render_template("surveyable/response_answers/index")
    end
  end
end
