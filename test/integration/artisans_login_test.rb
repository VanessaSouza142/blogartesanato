require "test_helper"

class ArtisansLoginTest < ActionDispatch::IntegrationTest
    def setup
        @artisan = Artisan.create!(name: "Vanessa", email: "vanessa@example.com", password: "password", password_confirmation: "password")
    end

    test "invalid login is rejected" do
        get login_path
        assert_template 'sessions/new'
        post login_path, params: { session: { email: " ", password: " " } }
        assert_template 'sessions/new'
        assert_not flash.empty?
        assert_select "a[href=?]", login_path
        assert_select "a[href=?]", logout_path, count: 0
        get root_path
        assert flash.empty?
    end

    test "valid login credentials accepted and begin session" do
        get login_path
        assert_template 'sessions/new'
        post login_path, params: { session: { email: @artisan.email, password: @artisan.password } }
        assert_redirected_to @artisan
        follow_redirect!
        assert_template 'artisans/show'
        assert_not flash.empty?
        assert_select "a[href=?]", login_path, count: 0
        assert_select "a[href=?]", logout_path
        assert_select "a[href=?]", artisan_path(@artisan)
        assert_select "a[href=?]", edit_artisan_path(@artisan)
    end
end
