require "test_helper"

class ArtisansTest < ActionDispatch::IntegrationTest
    def setup
        @artisan = Artisan.create!(name: "Vanessa", email: "vanessa@example.com", password: "password", password_confirmation: "password")
        @handcraft = Handcraft.create(name: "Painting", description: "Great handwork paintings with hot colors", artisan: @artisan)
        # another way
        @handcraft2 = @artisan.handcrafts.build(name: "Needlework", description: "Nice needlework with flowers")
        @handcraft2.save
    end

    test "should get artisans index" do
        get artisans_path
        assert_response :success        
    end

    test "should get artisans listing" do
        get artisans_path
        assert_template 'artisans/index'
        assert_select "a[href=?]", artisans_path(@artisans)
        assert_select "a[href=?]", artisans_path(@artisans2)
    end


end
