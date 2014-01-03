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

ActiveRecord::Schema.define(:version => 20140103081857) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

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

  create_table "cities", :force => true do |t|
    t.integer  "alt_id"
    t.string   "country_code"
    t.string   "name"
    t.spatial  "coordinates",  :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
  end

  add_index "cities", ["alt_id"], :name => "index_cities_on_alt_id", :unique => true
  add_index "cities", ["coordinates"], :name => "index_cities_on_coordinates", :spatial => true
  add_index "cities", ["name", "country_code"], :name => "index_cities_on_name_and_country_code", :unique => true

  create_table "contacts", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cycle_paths", :force => true do |t|
    t.string   "name"
    t.string   "details"
    t.decimal  "kilometers"
    t.spatial  "path",              :limit => {:srid=>4326, :type=>"line_string", :geographic=>true}
    t.spatial  "origin_coordinate", :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.spatial  "end_coordinate",    :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.boolean  "one_way"
    t.integer  "city_id"
    t.datetime "created_at",                                                                          :null => false
    t.datetime "updated_at",                                                                          :null => false
  end

  create_table "cycle_stations", :force => true do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "free_slots"
    t.integer  "bikes_available"
    t.spatial  "coordinates",     :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.string   "agency"
    t.datetime "created_at",                                                                  :null => false
    t.datetime "updated_at",                                                                  :null => false
  end

  create_table "cycling_group_admins", :force => true do |t|
    t.integer  "cycling_group_id"
    t.integer  "user_id"
    t.integer  "permissions"
    t.boolean  "verified"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "cycling_group_admins", ["cycling_group_id", "user_id"], :name => "index_cycling_group_admins_on_cycling_group_id_and_user_id", :unique => true

  create_table "cycling_groups", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "details"
    t.string   "meeting_time"
    t.string   "departing_time"
    t.string   "periodicity"
    t.string   "twitter_account"
    t.string   "facebook_url"
    t.string   "website_url"
    t.spatial  "coordinates",     :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.datetime "created_at",                                                                  :null => false
    t.datetime "updated_at",                                                                  :null => false
  end

  add_index "cycling_groups", ["name"], :name => "index_cycling_groups_on_name", :unique => true
  add_index "cycling_groups", ["slug"], :name => "index_cycling_groups_on_slug", :unique => true

  create_table "favorites", :force => true do |t|
    t.integer  "user_id",               :null => false
    t.integer  "favorited_object_id",   :null => false
    t.string   "favorited_object_type", :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "favorites", ["user_id", "favorited_object_id", "favorited_object_type"], :name => "unique_object_favorites_index", :unique => true

  create_table "instants", :force => true do |t|
    t.spatial  "coordinates",          :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.decimal  "speed"
    t.integer  "elapsed_time",         :limit => 8
    t.integer  "route_performance_id"
    t.datetime "created_at",                                                                       :null => false
    t.datetime "updated_at",                                                                       :null => false
  end

  create_table "ownerships", :force => true do |t|
    t.integer  "rank"
    t.integer  "kind",              :default => 0
    t.integer  "user_id"
    t.integer  "owned_object_id"
    t.string   "owned_object_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "ownerships", ["user_id", "owned_object_id", "owned_object_type"], :name => "unique_object_owners_index", :unique => true

  create_table "parkings", :force => true do |t|
    t.spatial  "coordinates",    :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.string   "details"
    t.integer  "kind"
    t.boolean  "has_roof"
    t.integer  "likes_count",                                                                :default => 0
    t.integer  "dislikes_count",                                                             :default => 0
    t.datetime "created_at",                                                                                :null => false
    t.datetime "updated_at",                                                                                :null => false
  end

  add_index "parkings", ["coordinates"], :name => "index_parkings_on_coordinates", :spatial => true
  add_index "parkings", ["coordinates"], :name => "unique_coordinates_parkings", :unique => true
  add_index "parkings", ["dislikes_count"], :name => "index_parkings_on_dislikes_count"
  add_index "parkings", ["likes_count"], :name => "index_parkings_on_likes_count"

  create_table "pictures", :force => true do |t|
    t.string   "caption"
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "ranked_comments", :force => true do |t|
    t.boolean  "positive"
    t.string   "content",                    :null => false
    t.integer  "user_id",                    :null => false
    t.integer  "ranked_comment_object_id",   :null => false
    t.string   "ranked_comment_object_type", :null => false
    t.integer  "ranked_comment_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "ranked_comments", ["user_id", "ranked_comment_object_id", "ranked_comment_object_type", "content"], :name => "unique_object_ranked_object_index", :unique => true

  create_table "route_performances", :force => true do |t|
    t.decimal  "average_speed"
    t.integer  "elapsed_time",  :limit => 8
    t.integer  "user_id"
    t.integer  "route_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "route_rankings", :force => true do |t|
    t.integer  "user_id",                      :null => false
    t.integer  "route_id",                     :null => false
    t.integer  "speed_index",   :default => 0
    t.integer  "comfort_index", :default => 0
    t.integer  "safety_index",  :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "route_rankings", ["user_id", "route_id"], :name => "unique_route_ranking_index", :unique => true

  create_table "routes", :force => true do |t|
    t.string   "name"
    t.string   "details"
    t.string   "extra_references"
    t.boolean  "is_public"
    t.decimal  "kilometers"
    t.spatial  "origin_coordinate", :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.spatial  "end_coordinate",    :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.integer  "likes_count",                                                                   :default => 0
    t.integer  "dislikes_count",                                                                :default => 0
    t.integer  "comfort_index",                                                                 :default => 0
    t.integer  "speed_index",                                                                   :default => 0
    t.integer  "safety_index",                                                                  :default => 0
    t.datetime "created_at",                                                                                   :null => false
    t.datetime "updated_at",                                                                                   :null => false
    t.spatial  "path",              :limit => {:srid=>4326, :type=>"line_string"}
  end

  create_table "segments", :force => true do |t|
    t.string   "color"
    t.spatial  "path",       :limit => {:srid=>4326, :type=>"line_string", :geographic=>true}
    t.string   "details"
    t.integer  "trip_id"
    t.datetime "created_at",                                                                   :null => false
    t.datetime "updated_at",                                                                   :null => false
  end

  create_table "tips", :force => true do |t|
    t.string   "content"
    t.integer  "category"
    t.spatial  "coordinates",    :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.integer  "likes_count",                                                                :default => 0
    t.integer  "dislikes_count",                                                             :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                                                                                :null => false
    t.datetime "updated_at",                                                                                :null => false
  end

  add_index "tips", ["coordinates"], :name => "index_tips_on_coordinates", :spatial => true
  add_index "tips", ["coordinates"], :name => "unique_coordinates_tips", :unique => true
  add_index "tips", ["dislikes_count"], :name => "index_tips_on_dislikes_count"
  add_index "tips", ["likes_count"], :name => "index_tips_on_likes_count"

  create_table "trip_pois", :force => true do |t|
    t.string   "name"
    t.string   "details"
    t.integer  "category"
    t.spatial  "coordinates", :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.integer  "trip_id"
    t.string   "icon_name"
    t.string   "picture_url"
    t.datetime "created_at",                                                              :null => false
    t.datetime "updated_at",                                                              :null => false
  end

  create_table "trips", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "details"
    t.spatial  "coordinates",  :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.string   "picture_name"
    t.string   "periodicity"
    t.datetime "created_at",                                                               :null => false
    t.datetime "updated_at",                                                               :null => false
  end

  add_index "trips", ["slug"], :name => "index_trips_on_slug", :unique => true

  create_table "user_roles", :force => true do |t|
    t.integer  "user_id"
    t.integer  "ring"
    t.string   "permissions"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "user_roles", ["user_id", "ring"], :name => "user_roles_index", :unique => true

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
    t.string   "authentication_token"
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
    t.integer  "phone",          :limit => 8
    t.integer  "cell_phone",     :limit => 8
    t.string   "webpage"
    t.string   "twitter"
    t.string   "horary"
    t.spatial  "coordinates",    :limit => {:srid=>4326, :type=>"point", :geographic=>true}
    t.integer  "likes_count",                                                                :default => 0
    t.integer  "dislikes_count",                                                             :default => 0
    t.datetime "created_at",                                                                                :null => false
    t.datetime "updated_at",                                                                                :null => false
  end

  add_index "workshops", ["coordinates"], :name => "index_workshops_on_coordinates", :spatial => true
  add_index "workshops", ["coordinates"], :name => "unique_coordinates_workshops", :unique => true
  add_index "workshops", ["dislikes_count"], :name => "index_workshops_on_dislikes_count"
  add_index "workshops", ["likes_count"], :name => "index_workshops_on_likes_count"

end
