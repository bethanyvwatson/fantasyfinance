class AddSessionTokenToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :session_token, :string
  end
end
