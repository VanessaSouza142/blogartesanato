class AddAdminToArtisans < ActiveRecord::Migration[7.0]
    add_column :artisans, :admin, :boolean, default: false
end
