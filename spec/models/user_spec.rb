require 'rails_helper'

describe User do
  before(:each) do
      @user = User.create(:id => "1")
      @user.uid = "12345" 
      @user.first_name = "John"
      @user.last_name = "Smith"
      @user.save
  end
  it 'should update credentials correctly' do
    @user.update_credentials({:token => "CBADEF...", :expires_at => 1321747205})
    assert_equal @user.oauth_token, "CBADEF..."
    assert_equal @user.oauth_expires_at, Time.at(1321747205)
  end
  it 'should update with information from Facebook' do
    @user.facebook_info_update({:uid => "54321", :extra => {:raw_info => {:gender => "male"}}, :info => {:first_name => "Bruce", :last_name => "Wayne", :image => "http://tinyurl.com/opnc38n", :location => "Bat Cave, Gotham", :email => "not_batman@wayneenterprises.com"}})
    assert_equal @user.uid, "54321"
    assert_equal @user.gender, "male"
    assert_equal @user.first_name, "Bruce"
    assert_equal @user.last_name, "Wayne"
    assert_equal @user.image, "http://tinyurl.com/olarge"
    assert_equal @user.location, "Bat Cave, Gotham"
    assert_equal @user.email, "not_batman@wayneenterprises.com"
  end
  it 'should correctly show full name' do
    assert_equal @user.full_name, "John Smith"
  end

  it 'should not save on invalid phone formats' do
    @user.phone_number = "abcd"
    @user.valid?
    @user.errors.should have_key(:phone_number)
  end

  it 'should save on valid phone format 1' do
    @user.phone_number = "(510)123-1234"
    @user.valid?
    @user.errors.should be_empty
  end

  it 'should save on valid phone format 2' do
    @user.phone_number = "(510) 123-1234"
    @user.valid?
    @user.errors.should be_empty
  end

  it 'should not save on invalid zipcode formats' do
    @user.zipcode= "abcd"
    @user.valid?
    @user.errors.should have_key(:zipcode)
  end

  it 'should save on valid zipcode format' do
    @user.zipcode = "12345"
    @user.valid?
    @user.errors.should be_empty
  end
end