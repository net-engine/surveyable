class AddCompletedByIdToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :completed_by_id, :integer
  end
end
