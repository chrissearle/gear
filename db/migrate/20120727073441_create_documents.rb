class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :path
      t.integer :item_id

      t.timestamps
    end
  end
end
