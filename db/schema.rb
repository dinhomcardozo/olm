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

ActiveRecord::Schema[8.0].define(version: 2025_01_16_231407) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "channels", primary_key: "channel_id", id: :serial, force: :cascade do |t|
    t.text "description"
    t.string "type", limit: 20
    t.integer "stage_id"
    t.string "channel_status", limit: 10
    t.integer "num_entries", default: 0
    t.integer "num_active_opps", default: 0
    t.decimal "active_opps_values", precision: 10, scale: 2, default: "0.0"
    t.decimal "total_sales_values", precision: 10, scale: 2, default: "0.0"
    t.integer "num_sales", default: 0
    t.decimal "loss_sales_values", precision: 10, scale: 2, default: "0.0"
    t.integer "num_loss_sales", default: 0
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
    t.check_constraint "channel_status::text = ANY (ARRAY['Ativo'::character varying::text, 'Inativo'::character varying::text])", name: "channels_channel_status_check"
    t.check_constraint "type::text = ANY (ARRAY['Telefone'::character varying::text, 'WhatsApp'::character varying::text, 'Telegram'::character varying::text, 'Messenger Facebook'::character varying::text, 'Instagram'::character varying::text, 'Formulário'::character varying::text, 'Chat'::character varying::text, 'E-mail'::character varying::text, 'Visita tecnica'::character varying::text])", name: "channels_type_check"
  end

  create_table "cities", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.integer "state_id", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "client_products", primary_key: "product_id", id: :integer, default: -> { "nextval('clientsproducts_product_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "product_type", limit: 20, null: false
    t.text "product_description"
    t.string "product_brand", limit: 100
    t.decimal "product_price", precision: 10, scale: 2, null: false
    t.string "product_cat", limit: 100
    t.string "product_status", limit: 10, null: false
    t.integer "product_license"
    t.integer "client_id", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
    t.check_constraint "product_status::text = ANY (ARRAY['Ativo'::character varying::text, 'Inativo'::character varying::text])", name: "clientsproducts_product_status_check"
    t.check_constraint "product_type::text = ANY (ARRAY['Physical Product'::character varying::text, 'Digital Product'::character varying::text, 'Service'::character varying::text])", name: "clientsproducts_product_type_check"
  end

  create_table "client_users", primary_key: ["client_id", "user_id"], force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
    t.index ["client_id"], name: "idx_client_id"
    t.index ["user_id"], name: "idx_user_id"
  end

  create_table "clients", primary_key: "client_id", id: :serial, force: :cascade do |t|
    t.integer "plan_id", null: false
    t.integer "num_client_users", default: 0
    t.string "cnpj", limit: 18, null: false
    t.integer "tax_regime_id", null: false
    t.integer "segment_id", null: false
    t.integer "subsegment_id"
    t.string "email", limit: 255, null: false
    t.string "telephone", limit: 15
    t.string "state", limit: 2
    t.string "city", limit: 40
    t.string "country", limit: 3
    t.string "address", limit: 50
    t.integer "address_number"
    t.string "state_registration", limit: 50
    t.string "city_registration", limit: 50
    t.integer "users_id", default: [], array: true
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"

    t.unique_constraint ["cnpj"], name: "clients_cnpj_key"
  end

  create_table "companies", primary_key: "company_id", id: :serial, force: :cascade do |t|
    t.string "company_name", limit: 255, null: false
    t.string "company_cnpj", limit: 18, null: false
    t.string "address", limit: 50
    t.integer "address_number"
    t.string "country", limit: 3
    t.string "state", limit: 2
    t.string "city", limit: 40
    t.integer "segment_id", null: false
    t.integer "subsegment_id"
    t.integer "tax_regime_id", null: false
    t.integer "group_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
    t.integer "client_id"

    t.unique_constraint ["company_cnpj"], name: "companies_company_cnpj_key"
  end

  create_table "contacts", primary_key: "contact_id", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 15, null: false
    t.string "last_name", limit: 15, null: false
    t.integer "company_id", null: false
    t.string "company_name", limit: 100
    t.string "telephone", limit: 20
    t.integer "group_id", null: false
    t.string "group_name", limit: 100
    t.integer "client_id"
    t.string "email", limit: 255
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"

    t.unique_constraint ["email"], name: "unique_email"
  end

  create_table "contract_client_products", id: :integer, default: -> { "nextval('contractsclientproducts_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "contract_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "contracts", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 15, null: false
    t.string "last_name", limit: 15, null: false
    t.integer "company_id", null: false
    t.string "company_name", limit: 100
    t.string "telephone", limit: 20
    t.integer "group_id", null: false
    t.integer "product_ids", null: false, array: true
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "group_clients", primary_key: ["group_id", "client_id"], force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "client_id", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "group_companies", primary_key: ["group_id", "company_id"], force: :cascade do |t|
    t.integer "group_id", null: false
    t.integer "company_id", null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "groups", primary_key: "group_id", id: :serial, force: :cascade do |t|
    t.integer "company_id", array: true
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "opportunities", primary_key: "opp_id", id: :serial, force: :cascade do |t|
    t.integer "stage_id"
    t.string "stage_name", limit: 50
    t.string "opp_status", limit: 10
    t.string "created_by", limit: 100
    t.datetime "updated_by", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.decimal "quote_value", precision: 10, scale: 2, default: "0.0"
    t.integer "product_list", array: true
    t.integer "contact_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "company_id"
    t.string "company_name", limit: 255
    t.check_constraint "opp_status::text = ANY (ARRAY['Ativo'::character varying::text, 'Inativo'::character varying::text])", name: "opportunities_opp_status_check"
    t.check_constraint "stage_name::text = ANY (ARRAY['Prospects'::character varying, 'Lead'::character varying, 'Demonstration'::character varying, 'Quote'::character varying, 'Sale'::character varying, 'LossSale'::character varying, 'PostSales'::character varying, 'AboutToRenew'::character varying, 'Renewed'::character varying, 'NotRenewed'::character varying]::text[])", name: "opportunities_stage_name_check"
  end

  create_table "opportunity_products", id: :serial, force: :cascade do |t|
    t.string "product_type", limit: 50, null: false
    t.integer "product_list", null: false, array: true
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.integer "opp_id", null: false
    t.integer "product_id", null: false
    t.integer "stage_id", null: false
    t.integer "created_by"
    t.integer "updated_by"
    t.check_constraint "product_type::text = ANY (ARRAY['prospected_product'::character varying, 'interested_product'::character varying, 'demonstrated_product'::character varying, 'quoted_product'::character varying, 'sold_product'::character varying, 'rejected_product'::character varying, 'canceled_product'::character varying]::text[])", name: "product_type_check"
  end

  create_table "plans", primary_key: "plan_id", id: :serial, force: :cascade do |t|
    t.string "plan_name", limit: 40, null: false
    t.text "plan_description"
    t.string "plan_status", limit: 10
    t.datetime "plan_validity", precision: nil
    t.decimal "plan_price", precision: 10, scale: 2
    t.string "created_by", limit: 100
    t.datetime "updated_by", precision: nil
    t.integer "num_plan_groups", default: 0
    t.integer "num_plan_clients", default: 0
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.check_constraint "plan_status::text = ANY (ARRAY['ativo'::character varying::text, 'inativo'::character varying::text])", name: "plans_plan_status_check"
  end

  create_table "product_brands", primary_key: "brand_id", id: :integer, default: -> { "nextval('productbrand_brand_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "brand_name", limit: 15
    t.string "brand_status", limit: 10
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
    t.check_constraint "brand_status::text = ANY (ARRAY['Ativo'::character varying::text, 'Inativo'::character varying::text])", name: "productbrand_brand_status_check"
  end

  create_table "segments", primary_key: "segment_id", id: :serial, force: :cascade do |t|
    t.string "segment_name", limit: 50, null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"

    t.unique_constraint ["segment_name"], name: "segments_segment_name_key"
  end

  create_table "stages", primary_key: "stage_id", id: :serial, force: :cascade do |t|
    t.string "stage_name", limit: 15, null: false
    t.text "stage_description"
    t.integer "num_active_opps", default: 0
    t.integer "num_contacts", default: 0
    t.integer "stage_position"
    t.boolean "stage_active"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"

    t.unique_constraint ["stage_name"], name: "unique_stage_name"
  end

  create_table "states", id: :serial, force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "abbreviation", limit: 2, null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"

    t.unique_constraint ["abbreviation"], name: "states_abbreviation_key"
  end

  create_table "sub_segments", primary_key: "subsegment_id", id: :integer, default: -> { "nextval('subsegments_subsegment_id_seq'::regclass)" }, force: :cascade do |t|
    t.string "subsegment_name", limit: 100, null: false
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"

    t.unique_constraint ["subsegment_name"], name: "subsegments_subsegment_name_key"
  end

  create_table "system_admins", primary_key: "admin_id", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 100, null: false
    t.string "last_name", limit: 100, null: false
    t.string "cpf", limit: 14
    t.string "cnpj", limit: 18
    t.string "email", limit: 255, null: false
    t.boolean "user_status"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "updated_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.boolean "super_admin", default: false
    t.string "password_digest"
    t.integer "created_by"
    t.integer "updated_by"

    t.unique_constraint ["cnpj"], name: "system_admins_cnpj_key"
    t.unique_constraint ["cpf"], name: "system_admins_cpf_key"
    t.unique_constraint ["email"], name: "system_admins_email_key"
  end

  create_table "tax_regimes", primary_key: "tax_regime_id", id: :serial, force: :cascade do |t|
    t.string "tax_regime", limit: 255, null: false
    t.integer "num_companies", default: 0
    t.integer "num_clients", default: 0
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
  end

  create_table "users", primary_key: "user_id", id: :serial, force: :cascade do |t|
    t.integer "client_id"
    t.string "first_name", limit: 15
    t.string "last_name", limit: 15
    t.string "user_status", limit: 10
    t.boolean "user_admin"
    t.string "country", limit: 3
    t.string "state", limit: 2
    t.string "city", limit: 40
    t.datetime "first_signin", precision: nil, default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "first_signup", precision: nil
    t.datetime "last_signup", precision: nil
    t.boolean "google_signin"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "created_by"
    t.integer "updated_by"
    t.string "email"
    t.string "encrypted_password", default: "", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.check_constraint "user_status::text = ANY (ARRAY['Ativo'::character varying::text, 'Inativo'::character varying::text])", name: "users_user_status_check"
  end

  add_foreign_key "channels", "stages", primary_key: "stage_id", name: "fk_stage_id"
  add_foreign_key "channels", "users", column: "created_by", primary_key: "user_id", name: "channels_created_by_fk", on_delete: :nullify
  add_foreign_key "channels", "users", column: "updated_by", primary_key: "user_id", name: "channels_updated_by_fk", on_delete: :nullify
  add_foreign_key "cities", "states", name: "cities_state_id_fkey", on_delete: :cascade
  add_foreign_key "cities", "users", column: "created_by", primary_key: "user_id", name: "cities_created_by_fk", on_delete: :nullify
  add_foreign_key "cities", "users", column: "updated_by", primary_key: "user_id", name: "cities_updated_by_fk", on_delete: :nullify
  add_foreign_key "client_products", "clients", primary_key: "client_id", name: "clientsproducts_client_id_fkey", on_delete: :cascade
  add_foreign_key "client_products", "users", column: "created_by", primary_key: "user_id", name: "client_products_created_by_fk", on_delete: :nullify
  add_foreign_key "client_products", "users", column: "updated_by", primary_key: "user_id", name: "client_products_updated_by_fk", on_delete: :nullify
  add_foreign_key "client_users", "clients", primary_key: "client_id", name: "clients_users_client_id_fkey", on_delete: :cascade
  add_foreign_key "client_users", "users", column: "created_by", primary_key: "user_id", name: "client_users_created_by_fk", on_delete: :nullify
  add_foreign_key "client_users", "users", column: "updated_by", primary_key: "user_id", name: "client_users_updated_by_fk", on_delete: :nullify
  add_foreign_key "client_users", "users", primary_key: "user_id", name: "clients_users_user_id_fkey", on_delete: :cascade
  add_foreign_key "clients", "plans", primary_key: "plan_id", name: "clients_plan_id_fkey"
  add_foreign_key "clients", "segments", primary_key: "segment_id", name: "clients_segment_id_fkey"
  add_foreign_key "clients", "sub_segments", column: "subsegment_id", primary_key: "subsegment_id", name: "clients_subsegment_id_fkey"
  add_foreign_key "clients", "users", column: "created_by", primary_key: "user_id", name: "clients_created_by_fk", on_delete: :nullify
  add_foreign_key "clients", "users", column: "updated_by", primary_key: "user_id", name: "clients_updated_by_fk", on_delete: :nullify
  add_foreign_key "companies", "clients", primary_key: "client_id", name: "fk_client"
  add_foreign_key "companies", "segments", primary_key: "segment_id", name: "companies_segment_id_fkey"
  add_foreign_key "companies", "sub_segments", column: "subsegment_id", primary_key: "subsegment_id", name: "companies_subsegment_id_fkey"
  add_foreign_key "companies", "users", column: "created_by", primary_key: "user_id", name: "companies_created_by_fk", on_delete: :nullify
  add_foreign_key "companies", "users", column: "updated_by", primary_key: "user_id", name: "companies_updated_by_fk", on_delete: :nullify
  add_foreign_key "contacts", "groups", primary_key: "group_id", name: "fk_group"
  add_foreign_key "contacts", "users", column: "created_by", primary_key: "user_id", name: "contacts_created_by_fk", on_delete: :nullify
  add_foreign_key "contacts", "users", column: "updated_by", primary_key: "user_id", name: "contacts_updated_by_fk", on_delete: :nullify
  add_foreign_key "contract_client_products", "client_products", column: "product_id", primary_key: "product_id", name: "contractsclientproducts_product_id_fkey", on_delete: :cascade
  add_foreign_key "contract_client_products", "contracts", name: "contractsclientproducts_contract_id_fkey", on_delete: :cascade
  add_foreign_key "contract_client_products", "users", column: "created_by", primary_key: "user_id", name: "contract_client_products_created_by_fk", on_delete: :nullify
  add_foreign_key "contract_client_products", "users", column: "updated_by", primary_key: "user_id", name: "contract_client_products_updated_by_fk", on_delete: :nullify
  add_foreign_key "contracts", "companies", primary_key: "company_id", name: "contracts_company_id_fkey", on_delete: :cascade
  add_foreign_key "contracts", "groups", primary_key: "group_id", name: "contracts_group_id_fkey", on_delete: :cascade
  add_foreign_key "contracts", "users", column: "created_by", primary_key: "user_id", name: "contracts_created_by_fk", on_delete: :nullify
  add_foreign_key "contracts", "users", column: "updated_by", primary_key: "user_id", name: "contracts_updated_by_fk", on_delete: :nullify
  add_foreign_key "group_clients", "groups", primary_key: "group_id", name: "group_clients_group_id_fkey"
  add_foreign_key "group_clients", "users", column: "created_by", primary_key: "user_id", name: "group_clients_created_by_fk", on_delete: :nullify
  add_foreign_key "group_clients", "users", column: "updated_by", primary_key: "user_id", name: "group_clients_updated_by_fk", on_delete: :nullify
  add_foreign_key "group_companies", "groups", primary_key: "group_id", name: "group_companies_group_id_fkey"
  add_foreign_key "group_companies", "users", column: "created_by", primary_key: "user_id", name: "group_companies_created_by_fk", on_delete: :nullify
  add_foreign_key "group_companies", "users", column: "updated_by", primary_key: "user_id", name: "group_companies_updated_by_fk", on_delete: :nullify
  add_foreign_key "groups", "users", column: "created_by", primary_key: "user_id", name: "groups_created_by_fk", on_delete: :nullify
  add_foreign_key "groups", "users", column: "updated_by", primary_key: "user_id", name: "groups_updated_by_fk", on_delete: :nullify
  add_foreign_key "opportunities", "companies", primary_key: "company_id", name: "fk_company_id"
  add_foreign_key "opportunities", "stages", primary_key: "stage_id", name: "fk_stage"
  add_foreign_key "opportunity_products", "client_products", column: "product_id", primary_key: "product_id", name: "fk_product", on_delete: :cascade
  add_foreign_key "opportunity_products", "opportunities", column: "opp_id", primary_key: "opp_id", name: "fk_opp_id"
  add_foreign_key "opportunity_products", "opportunities", column: "opp_id", primary_key: "opp_id", name: "fk_opportunity", on_delete: :cascade
  add_foreign_key "opportunity_products", "stages", primary_key: "stage_id", name: "fk_stage", on_delete: :cascade
  add_foreign_key "opportunity_products", "users", column: "created_by", primary_key: "user_id", name: "opportunity_products_created_by_fk", on_delete: :nullify
  add_foreign_key "opportunity_products", "users", column: "updated_by", primary_key: "user_id", name: "opportunity_products_updated_by_fk", on_delete: :nullify
  add_foreign_key "product_brands", "users", column: "created_by", primary_key: "user_id", name: "product_brands_created_by_fk", on_delete: :nullify
  add_foreign_key "product_brands", "users", column: "updated_by", primary_key: "user_id", name: "product_brands_updated_by_fk", on_delete: :nullify
  add_foreign_key "segments", "users", column: "created_by", primary_key: "user_id", name: "segments_created_by_fk", on_delete: :nullify
  add_foreign_key "segments", "users", column: "updated_by", primary_key: "user_id", name: "segments_updated_by_fk", on_delete: :nullify
  add_foreign_key "stages", "users", column: "created_by", primary_key: "user_id", name: "stages_created_by_fk", on_delete: :nullify
  add_foreign_key "stages", "users", column: "updated_by", primary_key: "user_id", name: "stages_updated_by_fk", on_delete: :nullify
  add_foreign_key "states", "users", column: "created_by", primary_key: "user_id", name: "states_created_by_fk", on_delete: :nullify
  add_foreign_key "states", "users", column: "updated_by", primary_key: "user_id", name: "states_updated_by_fk", on_delete: :nullify
  add_foreign_key "sub_segments", "users", column: "created_by", primary_key: "user_id", name: "sub_segments_created_by_fk", on_delete: :nullify
  add_foreign_key "sub_segments", "users", column: "updated_by", primary_key: "user_id", name: "sub_segments_updated_by_fk", on_delete: :nullify
  add_foreign_key "system_admins", "users", column: "created_by", primary_key: "user_id", name: "system_admins_created_by_fk", on_delete: :nullify
  add_foreign_key "system_admins", "users", column: "updated_by", primary_key: "user_id", name: "system_admins_updated_by_fk", on_delete: :nullify
  add_foreign_key "tax_regimes", "users", column: "created_by", primary_key: "user_id", name: "tax_regimes_created_by_fk", on_delete: :nullify
  add_foreign_key "tax_regimes", "users", column: "updated_by", primary_key: "user_id", name: "tax_regimes_updated_by_fk", on_delete: :nullify
  add_foreign_key "users", "clients", primary_key: "client_id", name: "fk_client_id"
  add_foreign_key "users", "users", column: "created_by", primary_key: "user_id", name: "users_created_by_fk", on_delete: :nullify
  add_foreign_key "users", "users", column: "updated_by", primary_key: "user_id", name: "users_updated_by_fk", on_delete: :nullify
end
