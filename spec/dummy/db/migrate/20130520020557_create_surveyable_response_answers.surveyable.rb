# This migration comes from surveyable (originally 20130520020406)
class CreateSurveyableResponseAnswers < ActiveRecord::Migration
  def change
    create_table :surveyable_response_answers do |t|
      t.references :response
      t.references :question
      t.references :answer
      t.text :free_content

      t.timestamps
    end
    add_index :surveyable_response_answers, :response_id
    add_index :surveyable_response_answers, :question_id
    add_index :surveyable_response_answers, :answer_id
  end
end
