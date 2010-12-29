class CreateTrails < ActiveRecord::Migration
  def self.up
    create_table :trails do |t|
      t.string :title
      t.integer :sort_index
      t.integer :user_id
      t.integer :column_id

      t.timestamps
    end
  end

  def self.down
    drop_table :trails
  end
end
