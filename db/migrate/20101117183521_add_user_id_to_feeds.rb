class AddUserIdToFeeds < ActiveRecord::Migration
  def self.up
    add_column :feeds, :user_id, :Integer
  end

  def self.down
    remove_column :feeds, :user_id
  end
end
