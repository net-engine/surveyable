class CreateSurveyableAnswers < ActiveRecord::Migration
  def change
    create_table :surveyable_answers do |t|
      t.references :question
      t.integer :position
      t.text :content

      t.timestamps
    end
    add_index :surveyable_answers, :question_id
  end
end
