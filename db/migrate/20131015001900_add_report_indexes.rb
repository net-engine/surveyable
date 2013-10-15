class AddReportIndexes < ActiveRecord::Migration
  def up
    # this index speeds up a lot the often used query : survey.responses.completed
    # the order matters here: survey_id is more selective than completed_at not null
    add_index :responses, [:survey_id, :completed_at]

    # this index speeds up the query based on question type such as
    # Question.where( field_type: Surveyable::Question::REPORTABLE_TYPES )
    add_index :questions, :field_type
  end

  def down
    remove_index :reponses, [:survey_id, :completed_at]
    remove_index :questions,:field_type
  end
end
