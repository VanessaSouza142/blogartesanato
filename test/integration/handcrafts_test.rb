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
        assert_select 'a[href=?]', edit_handcraft_path(@handcraft), text: "Edit this handcraft"
        assert_select 'a[href=?]', handcraft_path(@handcraft), text: "Delete this handcraft"
        assert_select 'a[href=?]', handcrafts_path, text: "Return to handcrafts listing"  
    end

    test "create new valid handcraft" do
        get new_handcraft_path
        assert_template 'handcrafts/new'
        name_of_handcraft = "clay sculpture"
        description_of_handcraft = "a nice jar made with clay"
        assert_difference 'Handcraft.count', 1 do 
            post handcrafts_path, params: { handcraft: {name: name_of_handcraft, description: description_of_handcraft}}
        end
        follow_redirect!
        assert_match name_of_handcraft.capitalize, response.body
        assert_match description_of_handcraft, response.body
      end
      
      test "reject invalid handcraft submissions" do
        get new_handcraft_path
        assert_template 'handcrafts/new'
        assert_no_difference 'Handcraft.count' do
        post handcrafts_path, params: { handcraft: { name: " ", description: " " } }
        end
        assert_template 'handcrafts/new'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
      end

      
end
