class RemoveCompletedByIdFromResponses < ActiveRecord::Migration
  def change
    remove_column :responses, :completed_by_id, :integer
  end
end
