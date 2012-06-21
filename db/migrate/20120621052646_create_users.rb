class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => true, :default => ""
      t.string :email, :null => true, :default => ""

      t.timestamps
    end

    add_index :users, :name, :unique => false
    add_index :users, :email, :unique => false
  end
end
