require 'spec_helper'

module Surveyable
  describe 'Api V1 Surveys' do
    let!(:survey) { create(:survey_with_questions_and_answers) }

    let(:answer_params) { {  answers_attributes: { 0 => attributes_for(:answer) } } }
    let(:question_params) { { questions_attributes: { 0 => attributes_for(:question).merge(answer_params) } } }
    let(:survey_params) { { survey: attributes_for(:survey).merge(question_params) } }

    describe "GET index" do
      it "fetchs all surveys" do
        expected_body = { surveys: [survey_hash(survey)] }.to_json

        get '/surveyable/api/v1/surveys.json'

        response.body.should == expected_body
      end

      it "responds with 200" do
        get "/surveyable/api/v1/surveys.json"

        response.status.should == 200
      end
    end

    describe "GET show" do
      it "returns survey" do
        expected_body = {
          survey: survey_hash(survey)
        }.to_json

        get "/surveyable/api/v1/surveys/#{survey.id}.json"

        response.body.should == expected_body
      end

      it "responds with 200" do
        get "/surveyable/api/v1/surveys/#{survey.id}.json"

        response.status.should == 200
      end
    end

    describe "POST create" do
      it "creates new survey" do
        post "/surveyable/api/v1/surveys.json", survey_params

        expected_body = { survey: survey_hash(Survey.last) }.to_json

        response.body.should == expected_body
      end

      it "creates new survey" do
        expect {
          post "/surveyable/api/v1/surveys.json", survey_params
        }.to change(Surveyable::Survey, :count).by(1)
      end

      it "responds with 201" do
        post "/surveyable/api/v1/surveys.json", survey_params

        response.status.should == 201
      end
    end

    describe "DELETE destroy" do
      it "disables survey" do
        delete "/surveyable/api/v1/surveys/#{survey.id}.json"

        survey.reload.should_not be_enabled
      end

      it "responds with 204" do
        delete "/surveyable/api/v1/surveys/#{survey.id}.json"

        response.status.should == 204
      end
    end

    describe "PUT update" do
      it "updates survey" do
        put "/surveyable/api/v1/surveys/#{survey.id}.json", { survey: { title: "New title" } }

        survey.reload.title.should == "New title"
      end

      it "responds with 204" do
        put "/surveyable/api/v1/surveys/#{survey.id}.json", { survey: { title: "New title" } }

        response.status.should == 204
      end
    end
  end
end

def survey_hash(survey)
  questions = []
  survey.questions.each { |question| questions << question_hash(question) }

  {
    id: survey.id,
    title: survey.title,
    enabled: survey.enabled,
    questions: questions
  }
end

def question_hash(question)
  answers = []
  question.answers.each { |answer| answers << answer_hash(answer) }

  {
    id: question.id,
    content: question.content,
    field_type: question.field_type,
    required: question.required,
    answers: answers
  }
end

def answer_hash(answer)
  {
    id: answer.id,
    position: answer.position,
    content: answer.content
  }
end
