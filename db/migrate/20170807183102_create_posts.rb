class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :body
      t.datetime :posted_at
      t.string :status, null: false, default: "draft"

      t.timestamps null: false
    end
  end
end
