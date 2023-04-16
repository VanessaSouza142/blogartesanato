class Comment < ApplicationRecord
    validates :description, presence: true, length: { minimum: 4, maximum: 140 }
    belongs_to :artisan
    belongs_to :handcraft 
    validates :artisan_id, presence: true
    validates :handcraft_id, presence: true
    default_scope -> { order(updated_at: :desc)}
end