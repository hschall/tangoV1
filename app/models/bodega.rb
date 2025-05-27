class Bodega < ApplicationRecord
  validates :codigo, presence: true, uniqueness: true
  validates :nombre, presence: true
end
