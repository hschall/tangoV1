class CreateSucursales < ActiveRecord::Migration[7.1]
  def change
    create_table :sucursales do |t|
      t.string :codigo, null: false
      t.string :ruta, null: false
      t.string :direccion
      t.string :cp
      t.boolean :activo, default: true
      t.references :bodega, foreign_key: true

      t.timestamps
    end

    add_index :sucursales, :codigo, unique: true
  end
end
