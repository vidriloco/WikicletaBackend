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

ActiveRecord::Schema.define(:version => 20130419162322) do

  create_table "answers", :force => true do |t|
    t.integer  "meta_answer_option_id"
    t.integer  "meta_answer_item_id"
    t.integer  "survey_id"
    t.string   "open_value"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "lock_used"
    t.string   "vehicle_identifier"
    t.spatial  "coordinates",        :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.date     "date"
    t.time     "start_hour"
    t.time     "final_hour"
    t.integer  "user_id"
    t.integer  "bike_id"
    t.boolean  "solved",                                                                         :default => false
    t.datetime "created_at",                                                                                        :null => false
    t.datetime "updated_at",                                                                                        :null => false
  end

  add_index "incidents", ["coordinates"], :name => "index_incidents_on_coordinates", :spatial => true
  add_index "incidents", ["coordinates"], :name => "unique_coordinates_incidents", :unique => true

  create_table "meta_answer_items", :force => true do |t|
    t.integer  "meta_question_id"
    t.string   "human_value"
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meta_answer_options", :force => true do |t|
    t.integer  "meta_question_id"
    t.string   "human_value"
    t.string   "identifier"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meta_questions", :force => true do |t|
    t.integer  "meta_survey_id"
    t.string   "title"
    t.string   "instruction"
    t.string   "order_identifier"
    t.string   "type_of"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "place_comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.string   "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "promoteds", :force => true do |t|
    t.string   "headline",         :limit => 20
    t.string   "main_details",     :limit => 33
    t.text     "extra_details"
    t.integer  "likes_count",                    :default => 0
    t.integer  "promoter_info_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  create_table "promoter_infos", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.text     "tags"
    t.integer  "city_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "questions", :force => true do |t|
    t.integer  "meta_question_id"
    t.integer  "survey_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stickers", :force => true do |t|
    t.string   "details"
    t.string   "code"
    t.integer  "status",                                                                 :default => 1
    t.integer  "banned",                                                                 :default => 0
    t.boolean  "fake",                                                                   :default => false
    t.string   "email"
    t.spatial  "location",   :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime "created_at",                                                                                :null => false
    t.datetime "updated_at",                                                                                :null => false
  end

  add_index "stickers", ["location"], :name => "index_stickers_on_location", :spatial => true

  create_table "user_like_bikes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "bike_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "user_like_bikes", ["user_id", "bike_id"], :name => "uniqueness_likes_idx", :unique => true

  create_table "user_like_promoteds", :force => true do |t|
    t.integer  "user_id"
    t.integer  "promoted_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_like_promoteds", ["user_id", "promoted_id"], :name => "uniqueness_promoted_likes_idx", :unique => true

end
