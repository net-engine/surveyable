class CreateSurveyableResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :survey
      t.integer :respondable_id
      t.string :respondable_type
      t.timestamp :completed_at

      t.timestamps
    end
    add_index :responses, :survey_id
  end
end
