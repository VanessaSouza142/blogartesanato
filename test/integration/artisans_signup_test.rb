require "test_helper"

class ArtisansSignupTest < ActionDispatch::IntegrationTest
    test "should get signup path" do
        get signup_path
        assert_response :success
    end

    test "reject an invalid signup" do
        get signup_path
        assert_no_difference "Artisan.count" do
            post artisans_path, params: { artisan: { name: " ", email: " ", password: "password", password_confirmation: " " } }
        end
        assert_template 'artisans/new'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end

    test "accept valid signup" do
        get signup_path
        assert_difference "Artisan.count", 1 do
            post artisans_path, params: { artisan: { name: "vanessa", email: "vanessa@example.com", password: "password", password_confirmation: "password" } }
        end
        follow_redirect!
        assert_template 'artisans/show'
        assert_not flash.empty?
    end

end
