# This migration comes from surveyable (originally 20130520010252)
class CreateSurveyableQuestions < ActiveRecord::Migration
  def change
    create_table :surveyable_questions do |t|
      t.string :title
      t.references :survey
      t.string :field_type
      t.boolean :required, default: true

      t.timestamps
    end
    add_index :surveyable_questions, :survey_id
  end
end
