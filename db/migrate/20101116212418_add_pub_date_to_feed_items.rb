class AddPubDateToFeedItems < ActiveRecord::Migration
  def self.up
    add_column :feed_items, :pub_date, :DateTime
  end

  def self.down
    remove_column :feed_items, :pub_date
  end
end
