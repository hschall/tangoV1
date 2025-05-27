ActiveRecord::Schema[7.1].define(version: 2025_05_23_191531) do
  create_table "bodegas", force: :cascade do |t|
    t.string "codigo", null: false
    t.string "nombre", null: false
    t.string "direccion"
    t.string "cp"
    t.boolean "activo", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo"], name: "index_bodegas_on_codigo", unique: true
  end

  create_table "productos", force: :cascade do |t|
    t.string "sap_id", null: false
    t.string "nombre", null: false
    t.string "um_compras"
    t.string "um_inventario"
    t.string "um_ventas"
    t.decimal "costo", precision: 10, scale: 2
    t.decimal "precio_venta", precision: 10, scale: 2
    t.string "codigo_barras"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["codigo_barras"], name: "index_productos_on_codigo_barras", unique: true
    t.index ["sap_id"], name: "index_productos_on_sap_id", unique: true
  end

  create_table "sucursales", force: :cascade do |t|
    t.string "codigo", null: false
    t.string "ruta", null: false
    t.string "direccion"
    t.string "cp"
    t.boolean "activo", default: true
    t.integer "bodega_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bodega_id"], name: "index_sucursales_on_bodega_id"
    t.index ["codigo"], name: "index_sucursales_on_codigo", unique: true
  end

  add_foreign_key "sucursales", "bodegas"
end
