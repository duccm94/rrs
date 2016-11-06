class CreateLikeBooks < ActiveRecord::Migration
  def change
    create_table :like_books do |t|
      t.references :user, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
