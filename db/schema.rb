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

ActiveRecord::Schema.define(:version => 20080926171738) do

  create_table "brands", :force => true do |t|
    t.text     "name"
    t.string   "description"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.string   "stock_symbol"
    t.text     "description"
    t.string   "logo_url"
    t.string   "website_url"
    t.integer  "google_cid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "review_issues", :force => true do |t|
    t.integer  "review_id"
    t.integer  "issue_id"
    t.integer  "rating",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", :force => true do |t|
    t.text     "body"
    t.string   "status",     :null => false
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
