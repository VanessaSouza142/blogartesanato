require 'test_helper'

class HandcraftTest < ActiveSupport::TestCase
  
  def setup
    @artisan = Artisan.create!(name: "Vanessa", email: "vanessa@example.com")
    @handcraft = @artisan.handcrafts.build(name: "painting", description: "great craft painting")
  end

  test "handcraft without artisan should be invalid" do
    @handcraft.artisan_id = nil
    assert_not @handcraft.valid?
  end
  
  test "handcraft should be valid" do
    assert @handcraft.valid?
  end  
  
  test "name should be present" do
    @handcraft.name = " "
    assert_not @handcraft.valid?
  end
  
  test "description should be present" do
    @handcraft.description = " "
    assert_not @handcraft.valid?
  end
  
  test "description shouldn't be less than 5 characters" do
    @handcraft.description = "a" * 3
    assert_not @handcraft.valid?
  end
  
  test "description shouldn't be more than 500 characters" do
    @handcraft.description = "a" * 501
    assert_not @handcraft.valid?
  end
end