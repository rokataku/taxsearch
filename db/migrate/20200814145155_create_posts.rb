class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :title     , null: false
      t.text :url
      t.string :text     , null: false
      t.integer    :genre_id     , null: false
      t.timestamps
    end
  end
end
