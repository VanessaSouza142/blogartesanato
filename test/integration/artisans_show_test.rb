require "test_helper"

class ArtisansShowTest < ActionDispatch::IntegrationTest
    def setup
        @artisan = Artisan.create!(name: "Vanessa", email: "vanessa@example.com", password: "password", password_confirmation: "password")
        @handcraft = Handcraft.create(name: "Painting", description: "Great handwork paintings with hot colors", artisan: @artisan)
        # another way
        @handcraft2 = @artisan.handcrafts.build(name: "Needlework", description: "Nice needlework with flowers")
        @handcraft2.save
    end

    test "should get artisans show" do
        get artisan_path(@artisan)
        assert_template 'artisans/show'
        assert_select "a[href=?]", handcraft_path(@handcraft), text: @handcraft.name
        assert_select "a[href=?]", handcraft_path(@handcraft2), text: @handcraft2.name
        assert_match @handcraft.description, response.body
        assert_match @handcraft2.description, response.body
        assert_match @artisan.name, response.body
      end
end
