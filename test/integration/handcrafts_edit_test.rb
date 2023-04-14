require "test_helper"

class HandcraftsEditTest < ActionDispatch::IntegrationTest

    def setup
        @artisan = Artisan.create!(name: "Vanessa", email: "vanessa@example.com", password: "password", password_confirmation: "password")
        @handcraft = Handcraft.create(name: "Painting", description: "Great handwork paintings with hot colors", artisan: @artisan)
      end
      
      test "reject invalid handcraft update" do
        get edit_handcraft_path(@handcraft)
        assert_template 'handcrafts/edit'
        patch handcraft_path(@handcraft), params: { handcraft: { name: " ", description: "some description" } } 
        assert_template 'handcrafts/edit'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
      end

      test "successfully edit a recipe" do
        get edit_handcraft_path(@handcraft)
        assert_template 'handcrafts/edit'
        updated_name = "updated handcraft name"
        updated_description = "updated handcraft description"
        patch handcraft_path(@handcraft), params: { handcraft: { name: updated_name, description: updated_description } }
        assert_redirected_to @handcraft
        #follow_redirect!
        assert_not flash.empty?
        @handcraft.reload
        assert_match updated_name, @handcraft.name
        assert_match updated_description, @handcraft.description
      end
end
