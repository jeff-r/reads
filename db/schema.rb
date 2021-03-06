# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110109194314) do

  create_table "authentications", :force => true do |t|
    t.integer   "user_id"
    t.string    "provider"
    t.string    "uid"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "feed_items", :force => true do |t|
    t.string    "title"
    t.string    "link"
    t.integer   "feed_id"
    t.boolean   "read"
    t.text      "description"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.timestamp "pub_date"
    t.integer   "num_threadentries"
    t.boolean   "ignore_thread"
    t.string    "guid"
  end

  create_table "feeds", :force => true do |t|
    t.string    "url"
    t.string    "title"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "user_id"
    t.integer   "sort_order"
  end

  create_table "links", :force => true do |t|
    t.string    "title"
    t.string    "url"
    t.integer   "trail_id"
    t.integer   "sort_index"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "column_id"
  end

  create_table "reader_users", :force => true do |t|
    t.string    "email"
    t.string    "name"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "settings", :force => true do |t|
    t.integer   "user_id"
    t.integer   "current_trail_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "trails", :force => true do |t|
    t.string    "title"
    t.integer   "sort_index"
    t.integer   "user_id"
    t.integer   "column_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.text      "notes"
    t.string    "color"
    t.integer   "page_id"
  end

  create_table "users", :force => true do |t|
    t.string    "email",                               :default => "", :null => false
    t.string    "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string    "password_salt",                       :default => "", :null => false
    t.string    "reset_password_token"
    t.string    "remember_token"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                       :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
