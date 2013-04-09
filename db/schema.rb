# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130405063406) do

  create_table "authorizations", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.integer  "user_id"
    t.string   "secret"
    t.string   "token"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "authorizations", ["provider", "uid"], :name => "authorizations_provider_uid_idx", :unique => true
  add_index "authorizations", ["provider", "user_id"], :name => "authorizations_provider_user_id_idx", :unique => true

  create_table "bike_brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "bike_statuses", :force => true do |t|
    t.integer  "concept",      :default => 0
    t.boolean  "availability", :default => false
    t.integer  "bike_id"
    t.boolean  "only_friends", :default => true
    t.float    "hour_cost"
    t.float    "day_cost"
    t.float    "month_cost"
    t.float    "price"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "bike_statuses", ["bike_id", "concept"], :name => "bike_statuses_idx", :unique => true

  create_table "bikes", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "kind"
    t.integer  "bike_brand_id"
    t.string   "frame_number"
    t.integer  "user_id"
    t.float    "weight"
    t.integer  "main_picture"
    t.string   "model"
    t.integer  "likes_count",                                            :default => 0
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.spatial  "coordinates",   :limit => {:srid=>4326, :type=>"point"}
  end

  create_table "cities", :force => true do |t|
    t.string   "code"
    t.spatial  "coordinates", :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
  end

  add_index "cities", ["coordinates"], :name => "index_cities_on_coordinates", :spatial => true

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.integer  "user_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "comments", ["commentable_id"], :name => "index_comments_on_commentable_id"
  add_index "comments", ["commentable_type"], :name => "index_comments_on_commentable_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "incidents", :force => true do |t|
    t.string   "description"
    t.integer  "kind"
    t.boolean  "complaint_issued"
    t.boolean  "fixed"
    t.integer  "lock_used"
    t.string   "vehicle_identifier"
    t.spatial  "coordinates",        :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.date     "date"
    t.time     "start_hour"
    t.time     "final_hour"
    t.integer  "user_id"
    t.integer  "bike_id"
    t.datetime "created_at",                                                                     :null => false
    t.datetime "updated_at",                                                                     :null => false
  end

  add_index "incidents", ["coordinates"], :name => "index_incidents_on_coordinates", :spatial => true
  add_index "incidents", ["coordinates"], :name => "unique_coordinates_incidents", :unique => true

  create_table "parkings", :force => true do |t|
    t.spatial  "coordinates",        :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.string   "details"
    t.integer  "kind"
    t.boolean  "has_roof"
    t.boolean  "others_can_edit_it"
    t.integer  "user_id"
    t.datetime "created_at",                                                                     :null => false
    t.datetime "updated_at",                                                                     :null => false
  end

  add_index "parkings", ["coordinates"], :name => "index_parkings_on_coordinates", :spatial => true
  add_index "parkings", ["coordinates"], :name => "unique_coordinates_parkings", :unique => true

  create_table "pictures", :force => true do |t|
    t.string   "caption"
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "place_comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tips", :force => true do |t|
    t.string   "content"
    t.integer  "category"
    t.spatial  "coordinates", :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.integer  "likes_count",                                                             :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                                                                             :null => false
    t.datetime "updated_at",                                                                             :null => false
  end

  add_index "tips", ["coordinates"], :name => "index_tips_on_coordinates", :spatial => true
  add_index "tips", ["coordinates"], :name => "unique_coordinates_tips", :unique => true

  create_table "user_like_bikes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bike_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_like_bikes", ["user_id", "bike_id"], :name => "uniqueness_likes_idx", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "full_name"
    t.string   "username"
    t.text     "bio"
    t.string   "personal_page"
    t.date     "started_cycling_date"
    t.boolean  "email_visible"
    t.boolean  "externally_registered",  :default => false
    t.boolean  "seller_account"
    t.integer  "city_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "workshops", :force => true do |t|
    t.string   "name"
    t.string   "details"
    t.boolean  "store"
    t.integer  "phone",              :limit => 8
    t.integer  "cell_phone",         :limit => 8
    t.string   "webpage"
    t.string   "twitter"
    t.string   "horary"
    t.boolean  "others_can_edit_it"
    t.spatial  "coordinates",        :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.integer  "user_id"
    t.datetime "created_at",                                                                     :null => false
    t.datetime "updated_at",                                                                     :null => false
  end

  add_index "workshops", ["coordinates"], :name => "index_workshops_on_coordinates", :spatial => true
  add_index "workshops", ["coordinates"], :name => "unique_coordinates_workshops", :unique => true

end
