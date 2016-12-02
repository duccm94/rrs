class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :book_id
      t.string :title
      t.text :content
      t.decimal :rating
      t.decimal :rating_place
      t.decimal :rating_service
      t.decimal :rating_food
      t.decimal :rating_price

      t.references :user, index: true, foreign_key: true
      t.attachment :image

      t.timestamps null: false
    end
  end
end
