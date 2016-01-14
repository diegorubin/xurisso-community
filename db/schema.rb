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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160114122800) do

  create_table "albums", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description", limit: 65535
    t.integer  "user_id"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["album_id"], name: "index_albums_on_album_id", using: :btree
    t.index ["user_id"], name: "index_albums_on_user_id", using: :btree
  end

  create_table "books", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",  limit: 65535
    t.string   "abbreviation"
    t.string   "slug"
    t.integer  "testament_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chapters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "book_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "body",             limit: 65535
    t.boolean  "removed"
    t.boolean  "approved"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "priority",                 default: 0, null: false
    t.integer  "attempts",                 default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  end

  create_table "event_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "icon_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",          limit: 65535
    t.datetime "start_at"
    t.datetime "end_at"
    t.boolean  "published"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_category_id"
    t.boolean  "user_can_participate",               default: true
    t.text     "body",                 limit: 65535
    t.index ["user_id"], name: "index_events_on_user_id", using: :btree
  end

  create_table "events_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "event_id"
    t.integer "user_id"
  end

  create_table "groups", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description",    limit: 65535
    t.boolean  "only_by_invite"
    t.integer  "owner_id"
    t.boolean  "is_private"
    t.string   "cover"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "about"
    t.text     "body",            limit: 65535
    t.integer  "from_id"
    t.integer  "to_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "removed_by_from",               default: false
    t.boolean  "removed_by_to",                 default: false
    t.index ["from_id"], name: "index_messages_on_from_id", using: :btree
    t.index ["to_id"], name: "index_messages_on_to_id", using: :btree
  end

  create_table "notification_reads", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "notification_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["notification_id"], name: "index_notification_reads_on_notification_id", using: :btree
    t.index ["user_id"], name: "index_notification_reads_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "from_id"
    t.string   "from_type"
    t.integer  "to_id"
    t.string   "to_type"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "participations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "invited_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_id"], name: "index_participations_on_group_id", using: :btree
    t.index ["user_id"], name: "index_participations_on_user_id", using: :btree
  end

  create_table "photos", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description", limit: 65535
    t.integer  "user_id"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
    t.index ["album_id"], name: "index_photos_on_album_id", using: :btree
    t.index ["user_id"], name: "index_photos_on_user_id", using: :btree
  end

  create_table "survey_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "survey_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "survey_option_id"
    t.index ["survey_id"], name: "index_survey_answers_on_survey_id", using: :btree
    t.index ["user_id"], name: "index_survey_answers_on_user_id", using: :btree
  end

  create_table "survey_options", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "description", limit: 65535
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["survey_id"], name: "index_survey_options_on_survey_id", using: :btree
  end

  create_table "surveys", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.text     "description", limit: 65535
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",                    default: false
  end

  create_table "testaments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "login"
    t.date     "birthday"
    t.boolean  "admin",                  default: false
    t.boolean  "blocked",                default: false
    t.boolean  "removed",                default: false
    t.string   "permissions"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "avatar"
    t.boolean  "can_display_birthday"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  create_table "versicles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "chapter_id"
    t.text     "text",       limit: 65535
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "wall_messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "description", limit: 65535
    t.integer  "user_id"
    t.boolean  "blocked",                   default: false
    t.boolean  "removed",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["user_id"], name: "index_wall_messages_on_user_id", using: :btree
  end

  add_foreign_key "notification_reads", "notifications"
  add_foreign_key "notification_reads", "users"
  add_foreign_key "participations", "groups"
  add_foreign_key "participations", "users"
end
