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

ActiveRecord::Schema.define(version: 2018_11_06_085842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apply_vacations", force: :cascade do |t|
    t.date "get_start_date", comment: "取得開始日"
    t.decimal "get_days", comment: "取得日数"
    t.integer "authorizer_id", comment: "承認者ID"
    t.string "status", default: "applying", comment: "申請状態"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "applicant_id", comment: "申請者ID"
    t.index ["applicant_id"], name: "index_apply_vacations_on_applicant_id"
  end

  create_table "attendance_times", force: :cascade do |t|
    t.integer "user_id", comment: "ユーザーID"
    t.date "work_date", comment: "勤怠日付"
    t.time "work_start", comment: "出勤時間"
    t.time "work_end", comment: "退勤時間"
    t.string "status", comment: "勤怠状況"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", comment: "メールアドレス"
    t.string "name", comment: "ユーザー名"
    t.string "role", default: "employee", comment: "権限"
    t.decimal "paid_holiday_count", default: "10.0", comment: "残有休日数"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", comment: "パスワード"
  end

end
