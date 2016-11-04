class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.integer :category_id
      t.string :title
      t.string :author
      t.integer :number_of_pages
      t.datetime :publish_date
      t.decimal :rate_score, default: 0.0
      t.attachment :image

      t.timestamps null: false
    end
  end
end
