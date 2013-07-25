class AddRespondentToResponse < ActiveRecord::Migration
  def change
    add_column :responses, :respondent_type, :string
    add_column :responses, :respondent_id, :string
  end
end
