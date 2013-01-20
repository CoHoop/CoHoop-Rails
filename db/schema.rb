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

ActiveRecord::Schema.define(:version => 20121008205501) do

  create_table "documents", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "slug"
  end

  create_table "mailing_list_mails", :force => true do |t|
    t.string   "mail"
    t.string   "university"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "microhoops", :force => true do |t|
    t.string   "content",                       :null => false
    t.integer  "user_id",                       :null => false
    t.boolean  "urgent",     :default => false, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "microhoops", ["user_id", "created_at"], :name => "index_microhoops_on_user_id_and_created_at"

  create_table "microhoops_tags_relationships", :force => true do |t|
    t.integer  "microhoop_id"
    t.integer  "tag_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "microhoops_tags_relationships", ["microhoop_id", "tag_id"], :name => "index_microhoops_tags_relationships_on_microhoop_id_and_tag_id", :unique => true
  add_index "microhoops_tags_relationships", ["microhoop_id"], :name => "index_microhoops_tags_relationships_on_microhoop_id"
  add_index "microhoops_tags_relationships", ["tag_id"], :name => "index_microhoops_tags_relationships_on_tag_id"

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "tags", ["name"], :name => "index_tags_on_name", :unique => true

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "birth_date"
    t.string   "email"
    t.string   "university"
    t.text     "biography"
    t.string   "job"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_documents_relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "document_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "users_documents_relationships", ["document_id"], :name => "index_users_documents_relationships_on_document_id"
  add_index "users_documents_relationships", ["user_id", "document_id"], :name => "index_users_documents_relationships_on_user_id_and_document_id", :unique => true
  add_index "users_documents_relationships", ["user_id"], :name => "index_users_documents_relationships_on_user_id"

  create_table "users_tags_relationships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "tag_id"
    t.integer  "main_tag",   :default => 0
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "users_tags_relationships", ["tag_id"], :name => "index_users_tags_relationships_on_tag_id"
  add_index "users_tags_relationships", ["user_id", "tag_id"], :name => "index_users_tags_relationships_on_user_id_and_tag_id", :unique => true
  add_index "users_tags_relationships", ["user_id"], :name => "index_users_tags_relationships_on_user_id"

end
