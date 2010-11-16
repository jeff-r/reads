class CreateFeedItems < ActiveRecord::Migration
  def self.up
    create_table :feed_items do |t|
      t.string :title
      t.string :link
      t.integer :feed_id
      t.boolean :read
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :feed_items
  end
end
