class CreateAccessions < ActiveRecord::Migration
  def change
    create_table :accessions do |t|
      t.belongs_to :application
      t.belongs_to :user
      t.boolean :admin

      t.timestamps
    end
    add_index :accessions, :application_id
    add_index :accessions, :user_id
  end
end
