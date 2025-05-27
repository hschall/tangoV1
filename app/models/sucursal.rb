class Sucursal < ApplicationRecord
  belongs_to :bodega, optional: true

  validates :codigo, presence: true, uniqueness: true
  validates :ruta, presence: true
end
