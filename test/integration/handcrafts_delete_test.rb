require "test_helper"

class HandcraftsDeleteTest < ActionDispatch::IntegrationTest
    def setup
        @artisan = Artisan.create!(name: "Vanessa", email: "vanessa@example.com")
        @handcraft = Handcraft.create(name: "Painting", description: "Great handwork paintings with hot colors", artisan: @artisan)
      end

    test "successfully delete a handcraft" do
        get handcraft_path(@handcraft)
        assert_template 'handcrafts/show'
        assert_select 'a[href=?]', handcraft_path(@handcraft), text: "Delete this handcraft"
        assert_difference 'Handcraft.count', -1 do
            delete handcraft_path(@handcraft)
        end
        assert_redirected_to handcrafts_path
        assert_not flash.empty?
    end



end
