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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170609060159) do

  create_table "issues", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.string   "imageurl"
    t.string   "impact"
    t.float    "cost"
    t.index ["user_id", "created_at"], name: "index_issues_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_issues_on_user_id"
  end

  create_table "issues_social_interests", id: false, force: :cascade do |t|
    t.integer "issue_id",           null: false
    t.integer "social_interest_id", null: false
  end

  create_table "issues_users", id: false, force: :cascade do |t|
    t.integer "issue_id", null: false
    t.integer "user_id",  null: false
    t.index ["issue_id", "user_id"], name: "index_issues_users_on_issue_id_and_user_id"
    t.index ["user_id", "issue_id"], name: "index_issues_users_on_user_id_and_issue_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "interest_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["interest_id"], name: "index_relationships_on_interest_id"
    t.index ["user_id", "interest_id"], name: "index_relationships_on_user_id_and_interest_id", unique: true
    t.index ["user_id"], name: "index_relationships_on_user_id"
  end

  create_table "social_interests", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.integer  "followerscount"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "social_interests_users", id: false, force: :cascade do |t|
    t.integer "social_interest_id", null: false
    t.integer "user_id",            null: false
    t.index ["social_interest_id", "user_id"], name: "index_social_interests_users_on_social_interest_id_and_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "image_url"
    t.string   "email"
    t.date     "dob"
    t.string   "gender"
  end

end
