class CreateSurveyableQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.references :survey
      t.string :field_type
      t.boolean :required, default: true

      t.timestamps
    end
    add_index :questions, :survey_id
  end
end
