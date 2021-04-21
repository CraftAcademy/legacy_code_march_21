ActiveRecord::Schema.define(version: 20171219160021) do

  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "analyses", force: :cascade do |t|
    t.string "category"
    t.text "resource"
    t.hstore "results"
    t.string "request_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
