class AddKeyNameToApplication < ActiveRecord::Migration
  def change
    add_column :oauth_applications, :key_name, :string
  end
end
