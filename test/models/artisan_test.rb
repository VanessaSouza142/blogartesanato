require 'test_helper'

class ArtisanTest < ActiveSupport::TestCase
  
  def setup
    @artisan = Artisan.new(name: "Vanessa", email: "vanessa@example.com")
  end
  
  test "should be valid" do
    assert @artisan.valid?
  end
  
  test "name should be present" do
    @artisan.name = " "
    assert_not @artisan.valid?
  end
  
  test "name should be less than 30 characters" do
    @artisan.name = "a" * 31
    assert_not @artisan.valid?
  end
  
  test "email should be present" do
    @artisan.email = " "
    assert_not @artisan.valid?
  end
  
  test "email should not be too long" do
    @artisan.email = "a" * 245 + "@example.com"
    assert_not @artisan.valid?
  end
  
  test "email should accept correct format" do
    valid_emails = %w[user@example.com VANESSA@gmail.com V.first@yahoo.ca john+smith@co.uk.org]
    valid_emails.each do |valids|
      @artisan.email = valids
      assert @artisan.valid?, "#{valids.inspect} should be valid"
    end
  end
  
  test "should reject invalid addresses" do
    invalid_emails = %w[vanessa@example vanessa@example,com vanessa.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |invalids|
      @artisan.email = invalids
      assert_not @artisan.valid?, "#{invalids.inspect} should be invalid"
    end
  end 
  
  test "email should be unique and case insensitive" do
    duplicate_artisan = @artisan.dup
    duplicate_artisan.email = @artisan.email.upcase
    @artisan.save
    assert_not duplicate_artisan.valid?
  end
  
  test "email should be lower case before hitting db" do
    mixed_email = "JohN@ExampLe.com"
    @artisan.email = mixed_email
    @artisan.save
    assert_equal mixed_email.downcase, @artisan.reload.email 
  end
end
