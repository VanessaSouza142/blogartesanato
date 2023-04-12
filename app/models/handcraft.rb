class Handcraft < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true, length: { minimum: 5, maximum: 500 }
    belongs_to :artisan
    validates :artisan_id, presence: true
end
