require "test_helper"

class HandcraftsTest < ActionDispatch::IntegrationTest
    def setup
        @artisan = Artisan.create!(name: "Vanessa", email: "vanessa@example.com")
        @handcraft = Handcraft.create(name: "Painting", description: "Great handwork paintings with hot colors", artisan: @artisan)
        # another way
        @handcraft2 = @artisan.handcrafts.build(name: "Needlework", description: "Nice needlework with flowers")
        @handcraft2.save

    end

    test "should get handcrafts index" do
        get handcrafts_path
        assert_response :success        
    end

    test "should get handcrafts listing" do
        get handcrafts_path
        assert_template 'handcrafts/index'
        assert_select "a[href=?]", handcraft_path(@handcraft), text: @handcraft.name
        assert_select "a[href=?]", handcraft_path(@handcraft2), text: @handcraft2.name
    end

    test "should get handcrafts show" do
        get handcraft_path(@handcraft)
        assert_template 'handcrafts/show'
        assert_match @handcraft.name, response.body
        assert_match @handcraft.description, response.body
        assert_match @artisan.name, response.body  
    end
end
