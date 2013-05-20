# This migration comes from surveyable (originally 20130520003910)
class CreateSurveyableSurveys < ActiveRecord::Migration
  def change
    create_table :surveyable_surveys do |t|
      t.string :title
      t.boolean :enabled, default: true

      t.timestamps
    end
  end
end
