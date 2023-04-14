require "test_helper"

class ArtisansEditTest < ActionDispatch::IntegrationTest
    def setup
        @artisan = Artisan.create!(name: "Vanessa", email: "vanessa@example.com", password: "password", password_confirmation: "password")
    end

    test "reject an invalid edit" do
    get edit_artisan_path(@artisan)
    assert_template 'artisans/edit'
    patch artisan_path(@artisan), params: { artisan: { name: " ", email: "joao@example.com" } }
    assert_template 'artisans/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid signup" do
    get edit_artisan_path(@artisan)
    assert_template 'artisans/edit'
    patch artisan_path(@artisan), params: { artisan: { name: "joao1", email: "joao1@example.com" } }
    assert_redirected_to @artisan
    assert_not flash.empty?
    @artisan.reload
    assert_match "joao1", @artisan.name
    assert_match "joao1@example.com", @artisan.email
  end
end
