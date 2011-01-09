class AddPageIdToTrails < ActiveRecord::Migration
  def self.up
    add_column :trails, :page_id, :integer
  end

  def self.down
    remove_column :trails, :page_id
  end
end
