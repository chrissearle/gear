class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :serial
      t.integer :price
      t.string :currency
      t.integer :user_id
      t.string :purchased_from
      t.date :purchased_on

      t.timestamps
    end
  end
end
