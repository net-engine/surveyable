require 'spec_helper'

module Surveyable
  describe 'Api V1 Surveys' do
    let!(:survey) { create(:survey_with_questions_and_answers) }

    describe "GET index" do
      it "fetchs all surveys" do
        expected_body = {
          surveys: [survey_hash(survey)]
        }.to_json

        get '/surveyable/api/v1/surveys.json'

        response.body.should == expected_body
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
