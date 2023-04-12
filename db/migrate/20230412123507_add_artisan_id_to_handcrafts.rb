class AddArtisanIdToHandcrafts < ActiveRecord::Migration[7.0]
  def change
    add_column :handcrafts, :artisan_id, :integer
  end
end
