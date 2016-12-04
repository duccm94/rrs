class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :owner_id
      t.integer :recipient_id
      t.integer :content
      t.integer :review_id
      t.boolean :seen, default: false

      t.timestamps null: false
    end
  end
end
