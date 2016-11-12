class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.string :book_title
      t.string :book_author
      t.text :content
      t.integer :accept, default: 0

      t.timestamps null: false
    end
  end
end
