class AddIndexesToResponses < ActiveRecord::Migration
  def change
    add_index :responses, [:respondable_id, :respondable_type]
  end
end
