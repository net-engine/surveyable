class CreateSurveyableResponseAnswers < ActiveRecord::Migration
  def change
    create_table :response_answers do |t|
      t.references :response
      t.references :question
      t.references :answer
      t.text :free_content

      t.timestamps
    end
    add_index :response_answers, :response_id
    add_index :response_answers, :question_id
    add_index :response_answers, :answer_id
  end
end
