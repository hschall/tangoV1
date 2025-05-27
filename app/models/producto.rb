class Producto < ApplicationRecord
  validates :sap_id, presence: true, uniqueness: true
  validates :nombre, presence: true
  validates :codigo_barras, uniqueness: true, allow_blank: true
end
