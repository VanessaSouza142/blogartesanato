require "test_helper"

class HandcraftsTest < ActionDispatch::IntegrationTest
    def setup
        @artisan = Artisan.create!(name: "Vanessa", email: "vanessa@example.com")
        @handcraft = Handcraft.create(name: "painting", description: "great handwork paintings with hot colors", artisan: @artisan)
        # another way
        @handcraft2 = @artisan.handcrafts.build(name: "needlework", description: "nice needlework with flowers")
        @handcraft2.save

    end

    test "should get handcrafts index" do
        get handcrafts_path
        assert_response :success        
    end

    test "should get handcrafts listing" do
        get handcrafts_path
        assert_template 'handcrafts/index'
        assert_match @handcraft.name, response.body
        assert_match @handcraft2.name, response.body
    end
end
