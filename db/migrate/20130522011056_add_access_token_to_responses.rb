class AddAccessTokenToResponses < ActiveRecord::Migration
  def change
    add_column :surveyable_responses, :access_token, :string
  end
end
