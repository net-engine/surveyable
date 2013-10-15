class AddReportIndexes < ActiveRecord::Migration
  def up
    # this index speeds up a lot the often used query : survey.responses.completed
    # the order matters here: survey_id is more selective than completed_at not null
    add_index :responses, [:survey_id, :completed_at], name: "completed_responses"

    # this index speeds up the query based on question type such as
    # Question.where( field_type: Surveyable::Question::REPORTABLE_TYPES )
    add_index :questions, :field_type
  end

  def down
    # dropping a two columns index does not seem to work properly
    # we therefore run raw SQL in the database
    execute <<-SQL
        DROP INDEX "completed_responses";
    SQL
    remove_index :questions,:field_type
  end
end
