require "test_helper"

class ArtisansListingTest < ActionDispatch::IntegrationTest
    def setup
        @artisan = Artisan.create!(name: "Vanessa", email: "vanessa@example.com", password: "password", password_confirmation: "password")
        # another way
        @artisan2 = Artisan.create!(name: "Ana", email: "ana@example.com", password: "password", password_confirmation: "password")
        @admin_user = Artisan.create!(name: "Ana1", email: "ana1@example.com", password: "password", password_confirmation: "password", admin: true)
    end

    test "should get artisans listing" do
        get artisans_path
        assert_template 'artisans/index'
        assert_select "a[href=?]", artisan_path(@artisan), text: @artisan.name.capitalize
        assert_select "a[href=?]", artisan_path(@artisan2),text: @artisan2.name.capitalize
    end

    test "should delete artisan" do
        sign_in_as(@admin_user, "password")
        get artisans_path
        assert_template 'artisans/index'
        assert_difference 'Artisan.count', -1 do
            delete artisan_path(@artisan2)
        end
        assert_redirected_to artisans_path
        assert_not flash.empty?
    end

end
