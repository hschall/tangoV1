class CreateProductos < ActiveRecord::Migration[7.1]
  def change
    create_table :productos do |t|
      t.string :sap_id, null: false
      t.string :nombre, null: false
      t.string :um_compras
      t.string :um_inventario
      t.string :um_ventas
      t.decimal :costo, precision: 10, scale: 2
      t.decimal :precio_venta, precision: 10, scale: 2
      t.string :codigo_barras

      t.timestamps
    end

    add_index :productos, :sap_id, unique: true
    add_index :productos, :codigo_barras, unique: true
  end
end
