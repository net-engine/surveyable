class CreateSurveyableResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :survey
      t.integer :responseable_id
      t.string :responseable_type
      t.timestamp :completed_at

      t.timestamps
    end
    add_index :responses, :survey_id
  end
end
