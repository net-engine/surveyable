# This migration comes from surveyable (originally 20130520014637)
class CreateSurveyableResponses < ActiveRecord::Migration
  def change
    create_table :surveyable_responses do |t|
      t.references :survey
      t.integer :responseable_id
      t.string :responseable_type
      t.timestamp :completed_at

      t.timestamps
    end
    add_index :surveyable_responses, :survey_id
  end
end
