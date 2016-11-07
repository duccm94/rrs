class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :book_id
      t.text :content
      t.decimal :rating
      t.references :user, index: true, foreign_key: true
      t.attachment :image

      t.timestamps null: false
    end
  end
end
