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

ActiveRecord::Schema.define(version: 20171212180207) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "name"
    t.string "avatar"
    t.boolean "is_active"
    t.index ["confirmation_token"], name: "index_accounts_on_confirmation_token", unique: true
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "add_law_firms", force: :cascade do |t|
    t.bigint "lawyer_profile_id"
    t.integer "status"
    t.bigint "law_firm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["law_firm_id"], name: "index_add_law_firms_on_law_firm_id"
    t.index ["lawyer_profile_id"], name: "index_add_law_firms_on_lawyer_profile_id"
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "question_id"
    t.text "content"
    t.integer "total_vote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_answers_on_account_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "articles", force: :cascade do |t|
    t.bigint "account_id"
    t.string "title"
    t.text "content"
    t.bigint "category_id"
    t.integer "status"
    t.integer "total_vote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_articles_on_account_id"
    t.index ["category_id"], name: "index_articles_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "clips", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_clips_on_account_id"
    t.index ["article_id"], name: "index_clips_on_article_id"
  end

  create_table "comment_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "comment_anc_desc_udx", unique: true
    t.index ["descendant_id"], name: "comment_desc_idx"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "account_id"
    t.text "content"
    t.integer "type"
    t.integer "parent_id"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_comments_on_account_id"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
  end

  create_table "educations", force: :cascade do |t|
    t.bigint "lawyer_profile_id"
    t.integer "degree"
    t.date "start_time"
    t.date "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "university_id"
    t.index ["lawyer_profile_id"], name: "index_educations_on_lawyer_profile_id"
  end

  create_table "follow_categories", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "category_id"
    t.index ["account_id"], name: "index_follow_categories_on_account_id"
    t.index ["category_id"], name: "index_follow_categories_on_category_id"
  end

  create_table "history_advertises", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "category_id"
    t.integer "province_id"
    t.bigint "history_point_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_history_advertises_on_account_id"
    t.index ["category_id"], name: "index_history_advertises_on_category_id"
    t.index ["history_point_id"], name: "index_history_advertises_on_history_point_id"
  end

  create_table "history_points", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "point_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount"
    t.integer "total"
    t.index ["account_id"], name: "index_history_points_on_account_id"
    t.index ["point_id"], name: "index_history_points_on_point_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "picture"
    t.string "imageable_type"
    t.bigint "imageable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"
  end

  create_table "impressions", force: :cascade do |t|
    t.string "impressionable_type"
    t.integer "impressionable_id"
    t.integer "user_id"
    t.string "controller_name"
    t.string "action_name"
    t.string "view_name"
    t.string "request_hash"
    t.string "ip_address"
    t.string "session_hash"
    t.text "message"
    t.text "referrer"
    t.text "params"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
    t.index ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
    t.index ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
    t.index ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
    t.index ["impressionable_type", "impressionable_id", "params"], name: "poly_params_request_index"
    t.index ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
    t.index ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
    t.index ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
    t.index ["user_id"], name: "index_impressions_on_user_id"
  end

  create_table "law_firms", force: :cascade do |t|
    t.string "phone_number"
    t.string "fax"
    t.string "email"
    t.string "address"
    t.text "introduction"
    t.time "working_start_time"
    t.time "working_end_time"
    t.bigint "province_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "is_active", default: false
    t.string "avatar"
    t.index ["province_id"], name: "index_law_firms_on_province_id"
  end

  create_table "lawyer_profiles", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "point"
    t.string "lawyer_id"
    t.string "address"
    t.string "phone_number"
    t.boolean "is_active"
    t.boolean "is_manager"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "fax_number"
    t.text "introduction"
    t.integer "reputation"
    t.integer "law_firm_id"
    t.string "full_name"
    t.boolean "approved"
    t.string "lawyer_card_image"
    t.string "id_card_image"
    t.index ["account_id"], name: "index_lawyer_profiles_on_account_id"
  end

  create_table "notifies", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "target_id"
    t.string "notifyable_type"
    t.bigint "notifyable_id"
    t.integer "action"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.index ["account_id"], name: "index_notifies_on_account_id"
    t.index ["notifyable_type", "notifyable_id"], name: "index_notifies_on_notifyable_type_and_notifyable_id"
  end

  create_table "points", force: :cascade do |t|
    t.integer "option"
    t.integer "point_per_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "account_id"
    t.string "title"
    t.text "content"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_vote"
    t.index ["account_id"], name: "index_questions_on_account_id"
    t.index ["category_id"], name: "index_questions_on_category_id"
  end

  create_table "request_law_firms", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "status"
    t.bigint "law_firm_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_request_law_firms_on_account_id"
    t.index ["law_firm_id"], name: "index_request_law_firms_on_law_firm_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "account_id"
    t.string "reviewable_type"
    t.bigint "reviewable_id"
    t.string "content"
    t.integer "stars"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_reviews_on_account_id"
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable_type_and_reviewable_id"
  end

  create_table "tag_descriptions", force: :cascade do |t|
    t.bigint "tag_id"
    t.text "content"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_tag_descriptions_on_account_id"
    t.index ["tag_id"], name: "index_tag_descriptions_on_tag_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "universities", force: :cascade do |t|
    t.string "name"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "vote_type"
    t.bigint "account_id"
    t.string "voteable_type"
    t.bigint "voteable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_votes_on_account_id"
    t.index ["voteable_type", "voteable_id"], name: "index_votes_on_voteable_type_and_voteable_id"
  end

end
