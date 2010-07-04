# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 3) do

  create_table "books", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "author"
    t.date     "release_date"
    t.text     "description"
    t.string   "image_url_small"
    t.string   "image_url_medium"
    t.string   "image_url_large"
    t.string   "amazon_url"
    t.string   "isbn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books_users", :id => false, :force => true do |t|
    t.integer  "book_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.integer  "login_count"
    t.datetime "last_login"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end