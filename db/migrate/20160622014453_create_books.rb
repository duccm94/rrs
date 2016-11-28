class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :category_id
      t.string :title
      t.string :author
      t.string :description
      t.decimal :rate_score, default: 0.0
      t.decimal :rate_place, default: 0.0
      t.decimal :rate_service, default: 0.0
      t.decimal :rate_food, default: 0.0
      t.decimal :rate_price, default: 0.0

      t.attachment :image

      t.timestamps null: false
    end
  end
end
