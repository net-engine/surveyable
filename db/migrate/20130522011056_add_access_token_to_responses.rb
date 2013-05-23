class AddAccessTokenToResponses < ActiveRecord::Migration
  def change
    add_column :responses, :access_token, :string
  end
end
