# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110303140947) do

  create_table "addresses", :force => true do |t|
    t.string   "country",    :limit => 20
    t.string   "state",      :limit => 20
    t.string   "city"
    t.string   "street",     :limit => 50
    t.string   "location",   :limit => 20
    t.string   "zip_code",   :limit => 10
    t.string   "complement", :limit => 20
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cables", :force => true do |t|
    t.string   "name"
    t.integer  "span_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "network_type", :limit => 20
  end

  create_table "companies", :force => true do |t|
    t.string   "name",       :limit => 30
    t.string   "contact",    :limit => 30
    t.string   "phone",      :limit => 20
    t.string   "fax",        :limit => 20
    t.string   "email",      :limit => 50
    t.string   "website",    :limit => 50
    t.integer  "address_id"
    t.string   "code",       :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "diagrams", :force => true do |t|
    t.string   "name",          :limit => 20
    t.integer  "subracks_qty"
    t.integer  "subracks_rows"
    t.integer  "subracks_cols"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fibers", :force => true do |t|
    t.integer  "number_a"
    t.integer  "subrack_a_id"
    t.integer  "number_b"
    t.integer  "subrack_b_id"
    t.string   "status",       :limit => 1
    t.integer  "cable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jumpers", :force => true do |t|
    t.string   "connectors",  :limit => 20
    t.integer  "lenght",      :limit => 1
    t.string   "description"
    t.integer  "fiber_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_books", :force => true do |t|
    t.date     "log_date"
    t.string   "notes"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "network_owner_id"
    t.string   "name"
    t.string   "description"
    t.date     "begin_date"
    t.date     "end_date"
    t.string   "status",                    :limit => 2
    t.boolean  "has_test_orl",                           :default => false
    t.boolean  "has_test_chromatic",                     :default => false
    t.boolean  "has_test_site_survey",                   :default => false
    t.boolean  "has_test_otdr_standard",                 :default => false
    t.boolean  "has_test_otdr_premium",                  :default => false
    t.boolean  "has_test_attenuation_1550",              :default => false
    t.boolean  "has_test_attenuation_1310",              :default => false
    t.boolean  "has_test_pmd_10_min",                    :default => false
    t.boolean  "has_test_pmd_60_min",                    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", :force => true do |t|
    t.string   "name",             :limit => 30
    t.string   "acronym",          :limit => 10
    t.date     "install_date"
    t.string   "notes"
    t.integer  "network_owner_id"
    t.integer  "address_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites_additional_informations", :force => true do |t|
    t.string   "cable_type",               :limit => 10
    t.string   "fiber_type",               :limit => 10
    t.string   "cable_manufacturer",       :limit => 20
    t.date     "cable_manufacturing_date"
    t.string   "installer_company",        :limit => 20
    t.integer  "connectors_qty"
    t.integer  "splices_qty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spans", :force => true do |t|
    t.integer  "site_a_id"
    t.integer  "site_b_id"
    t.integer  "company_id"
    t.integer  "distance",      :limit => 10, :precision => 10, :scale => 0
    t.integer  "fiber_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id"
  end

  create_table "subracks", :force => true do |t|
    t.integer  "site_id"
    t.string   "room",            :limit => 5
    t.string   "floor",           :limit => 5
    t.string   "line",            :limit => 5
    t.string   "rack",            :limit => 5
    t.string   "grupo",           :limit => 5
    t.string   "connector",       :limit => 5
    t.integer  "total_fibers",    :limit => 1
    t.integer  "released_fibers", :limit => 1
    t.integer  "broken_fibers",   :limit => 1
    t.integer  "diagram_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",            :limit => 20
  end

  create_table "test_attenuations", :force => true do |t|
    t.integer  "fiber_id"
    t.integer  "test_type",        :limit => 1
    t.decimal  "ab_injected",                    :precision => 8, :scale => 4
    t.decimal  "ab_rcv_opt_power",               :precision => 8, :scale => 4
    t.decimal  "ab_opt_link_loss",               :precision => 8, :scale => 4
    t.decimal  "ba_injected",                    :precision => 8, :scale => 4
    t.decimal  "ba_rcv_opt_power",               :precision => 8, :scale => 4
    t.decimal  "ba_opt_link_loss",               :precision => 8, :scale => 4
    t.decimal  "mean_loss",                      :precision => 8, :scale => 4
    t.datetime "test_timestamp"
    t.string   "equipment",        :limit => 50
    t.string   "technique",        :limit => 50
    t.integer  "lambda",           :limit => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_chromatic_disps", :force => true do |t|
    t.integer  "fiber_id"
    t.decimal  "dsp_lambda_z",   :precision => 22, :scale => 10
    t.decimal  "dsp_1310",       :precision => 22, :scale => 10
    t.decimal  "dsp_1525",       :precision => 22, :scale => 10
    t.decimal  "dsp_1530",       :precision => 22, :scale => 10
    t.decimal  "dsp_1540",       :precision => 22, :scale => 10
    t.decimal  "dsp_1550",       :precision => 22, :scale => 10
    t.decimal  "dsp_1560",       :precision => 22, :scale => 10
    t.decimal  "dsp_1570",       :precision => 22, :scale => 10
    t.decimal  "dsp_1575",       :precision => 22, :scale => 10
    t.decimal  "dsp_1625",       :precision => 22, :scale => 10
    t.decimal  "dsp_total",      :precision => 22, :scale => 10
    t.decimal  "dsp_slopezero",  :precision => 22, :scale => 10
    t.decimal  "dsp_slopeother", :precision => 22, :scale => 10
    t.decimal  "dsp_coef_a",     :precision => 33, :scale => 16
    t.decimal  "dsp_coef_b",     :precision => 33, :scale => 16
    t.decimal  "dsp_coef_c",     :precision => 33, :scale => 16
    t.datetime "test_timestamp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_orls", :force => true do |t|
    t.integer  "fiber_id"
    t.decimal  "orl_ab",     :precision => 6, :scale => 2
    t.decimal  "orl_ba",     :precision => 6, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_otdrs", :id => false, :force => true do |t|
    t.integer  "id",                                       :default => 0, :null => false
    t.integer  "fiber_id"
    t.decimal  "orl_ab",     :precision => 6, :scale => 2
    t.decimal  "orl_ba",     :precision => 6, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_pmds", :force => true do |t|
    t.integer  "fiber_id",       :limit => 10, :precision => 10, :scale => 0
    t.decimal  "pmd_set1_a",                   :precision => 6,  :scale => 2
    t.decimal  "pmd_set1_b",                   :precision => 6,  :scale => 2
    t.decimal  "pmd_set1_c",                   :precision => 6,  :scale => 2
    t.decimal  "pmd_set2_a",                   :precision => 6,  :scale => 2
    t.decimal  "pmd_set2_b",                   :precision => 6,  :scale => 2
    t.decimal  "pmd_set3_c",                   :precision => 6,  :scale => 2
    t.decimal  "pmd_set3_a",                   :precision => 6,  :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "pmd_set2_c",                   :precision => 6,  :scale => 2
    t.decimal  "pmd_set3_b",                   :precision => 6,  :scale => 2
    t.decimal  "optical_length",               :precision => 15, :scale => 6
  end

  create_table "users", :force => true do |t|
    t.string   "name",                :limit => 50
    t.string   "login",               :limit => 20
    t.string   "email",               :limit => 50
    t.string   "hashed_password",     :limit => 100
    t.string   "salt",                :limit => 100
    t.date     "expiration"
    t.integer  "status",              :limit => 1
    t.integer  "company_id"
    t.string   "company_description", :limit => 20
    t.string   "contact_phone",       :limit => 20
    t.string   "comments",            :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_logs", :force => true do |t|
    t.date     "access_date"
    t.time     "time_using"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_projects", :force => true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role",       :limit => 2
  end

end
