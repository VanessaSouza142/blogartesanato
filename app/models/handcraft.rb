class Handcraft < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true, length: { minimum: 5, maximum: 500 }
    belongs_to :artisan
    validates :artisan_id, presence: true
    default_scope -> { order(updated_at: :desc) }
    has_many :handcraft_materials
    has_many :materials, through: :handcraft_materials
end
