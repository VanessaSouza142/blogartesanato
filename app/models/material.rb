class Material < ApplicationRecord
    validates :name, presence: true, length: { minimum: 3, maximum: 25 }
    validates_uniqueness_of :name
    has_many :handcraft_materials
    has_many :handcrafts, through: :handcraft_materials
end