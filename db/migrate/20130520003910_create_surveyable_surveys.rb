class CreateSurveyableSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title
      t.boolean :enabled, default: true

      t.timestamps
    end
  end
end
