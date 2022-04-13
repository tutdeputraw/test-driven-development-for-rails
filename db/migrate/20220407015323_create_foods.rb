class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.text :description
      t.integer :price
      t.integer :category_id

      t.timestamps
    end
  end
end
