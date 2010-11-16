class CreateReaderUsers < ActiveRecord::Migration
  def self.up
    create_table :reader_users do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :reader_users
  end
end
