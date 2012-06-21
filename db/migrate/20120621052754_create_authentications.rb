class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.integer :user_id

      t.timestamps
    end

    add_index :authentications, :provider, :unique => false
    add_index :authentications, :user_id
  end
end
