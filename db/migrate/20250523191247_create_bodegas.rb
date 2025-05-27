class CreateBodegas < ActiveRecord::Migration[7.1]
  def change
    create_table :bodegas do |t|
      t.string :codigo, null: false
      t.string :nombre, null: false
      t.string :direccion
      t.string :cp
      t.boolean :activo, default: true

      t.timestamps
    end

    add_index :bodegas, :codigo, unique: true
  end
end
