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

ActiveRecord::Schema.define(version: 2021_01_30_174011) do

  create_table "redirect_events", force: :cascade do |t|
    t.integer "url_map_id"
    t.string "ip_address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["url_map_id"], name: "index_redirect_events_on_url_map_id"
  end

  create_table "url_maps", force: :cascade do |t|
    t.string "url"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "redirect_events_id"
    t.index ["redirect_events_id"], name: "index_url_maps_on_redirect_events_id"
  end

  add_foreign_key "url_maps", "redirect_events", column: "redirect_events_id"
end
