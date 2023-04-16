class CreateHandcraftMaterials < ActiveRecord::Migration[7.0]
  def change
    create_table :handcraft_materials do |t|
        t.integer :handcraft_id
        t.integer :material_id
    end
  end
end
