class AddNotesToTrail < ActiveRecord::Migration
  def self.up
    add_column :trails, :notes, :text
    add_column :trails, :color, :string
  end

  def self.down
    remove_column :trails, :color
    remove_column :trails, :notes
  end
end
