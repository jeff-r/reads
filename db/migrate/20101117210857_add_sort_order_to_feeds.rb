class AddSortOrderToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :sort_order, :integer
  end

  def self.down
    remove_column :feeds, :sort_order
  end
end
