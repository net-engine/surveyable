require 'spec_helper'

describe "Create survey" do
  it "adds new survey", js: true do
    visit new_surveyable_survey_path

    fill_in "Survey name", with: "Survey #1"

    all_questions = all('.question_field')

    within(all_questions.first) do
      fill_in 'surveyable_survey_questions_attributes_0_content', with: "How are you today?"
      select 'Radio Button Field', from: 'Answer type'
      fill_in 'surveyable_survey_questions_attributes_0_answers_attributes_0_content', with: 'Good'
      fill_in 'surveyable_survey_questions_attributes_0_answers_attributes_1_content', with: 'Bad'
    end

    within(all_questions.last) do
      fill_in 'surveyable_survey_questions_attributes_2_content', with: "How many cars do you have?"
      select 'Check Box Field', from: 'Answer type'
      fill_in 'surveyable_survey_questions_attributes_2_answers_attributes_0_content', with: '1'
      fill_in 'surveyable_survey_questions_attributes_2_answers_attributes_1_content', with: '2+'
    end

    click_on "Save"

    page.should have_content("Survey #1")

    Surveyable::Survey.count.should == 1
    Surveyable::Survey.last.questions.count.should == 2
  end
end
