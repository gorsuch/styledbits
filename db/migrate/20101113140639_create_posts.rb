class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :account_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
