require 'spec_helper'

describe "Update survey" do
  let!(:survey) { create(:survey_with_questions_and_answers) }

  it "updates survey", js: true do
    pending "Dummy application not loading JS - to investigate further"

    visit edit_surveyable_survey_path(survey.id)

    fill_in "Survey name", with: "Survey new name"

    all_questions = all('.question')

    within(all_questions.first) do
      fill_in 'surveyable_survey_questions_attributes_0_content', with: "How good is to be alive?"
      select 'Radio Button Field', from: 'Answer type'
      fill_in 'surveyable_survey_questions_attributes_0_answers_attributes_0_content', with: 'Good'
      fill_in 'surveyable_survey_questions_attributes_0_answers_attributes_1_content', with: 'Bad'

      click_on 'Add answer'

      added_answer_input = all('td input').last
      fill_in added_answer_input, with: "Cool"
    end

    click_on "Save"

    page.should have_content("Survey created successfully.")
    page.should have_content("Survey #1")

    Surveyable::Survey.count.should == 1
    Surveyable::Survey.last.questions.count.should == 2
  end
end

