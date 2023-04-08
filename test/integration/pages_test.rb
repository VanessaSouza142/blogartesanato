require "test_helper"

class PagesTest < ActionDispatch::IntegrationTest
    test "should get home" do
        get pages_home_url
        assert_response :sucess
    end

    test "should get root" do
        get root_url
        asserta_response :sucess
    end

end
