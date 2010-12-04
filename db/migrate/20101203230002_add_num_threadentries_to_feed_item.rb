class AddNumThreadentriesToFeedItem < ActiveRecord::Migration
  def self.up
    add_column :feed_items, :num_threadentries, :integer
    add_column :feed_items, :ignore_thread, :boolean
  end

  def self.down
    remove_column :feed_items, :num_threadentries
    remove_column :feed_items, :ignore_thread
  end
end
