# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_13_060222) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string "name", null: false
    t.string "image"
    t.decimal "percentage_raised", precision: 8, scale: 2, default: "0.0"
    t.decimal "target_amount", null: false
    t.string "province", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "funds", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.string "donor_name", null: false
    t.string "phone_number", null: false
    t.decimal "donation_amount", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_funds_on_employee_id"
  end

  add_foreign_key "funds", "employees"
end
