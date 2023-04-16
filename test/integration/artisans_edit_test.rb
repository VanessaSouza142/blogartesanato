require "test_helper"

class ArtisansEditTest < ActionDispatch::IntegrationTest
    def setup
        @artisan = Artisan.create!(name: "Vanessa", email: "vanessa@example.com", password: "password", password_confirmation: "password")
        @artisan2 = Artisan.create!(name: "Ana", email: "ana@example.com", password: "password", password_confirmation: "password")
        @admin_user = Artisan.create!(name: "Ana1", email: "ana1@example.com", password: "password", password_confirmation: "password", admin: true)
    
    end

    test "reject an invalid edit" do
    sign_in_as(@artisan, "password")
    get edit_artisan_path(@artisan)
    assert_template 'artisans/edit'
    patch artisan_path(@artisan), params: { artisan: { name: " ", email: "joao@example.com" } }
    assert_template 'artisans/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
  
  test "accept valid edit" do
    sign_in_as(@artisan, "password")
    get edit_artisan_path(@artisan)
    assert_template 'artisans/edit'
    patch artisan_path(@artisan), params: { artisan: { name: "joao1", email: "joao1@example.com" } }
    assert_redirected_to @artisan
    assert_not flash.empty?
    @artisan.reload
    assert_match "joao1", @artisan.name
    assert_match "joao1@example.com", @artisan.email
  end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, "password")
    get edit_artisan_path(@artisan)
    assert_template 'artisans/edit'
    patch artisan_path(@artisan), params: { artisan: { name: "joao3", email: "joao3@example.com" } }
    assert_redirected_to @artisan
    assert_not flash.empty?
    @artisan.reload
    assert_match "joao3", @artisan.name
    assert_match "joao3@example.com", @artisan.email
  end

  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@artisan2, "password")
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch artisan_path(@artisan), params: { artisan: { name: updated_name, email: updated_email } }
    assert_redirected_to artisans_path
    assert_not flash.empty?
    @artisan.reload
    assert_match "Vanessa", @artisan.name
    assert_match "vanessa@example.com", @artisan.email
  end
end
