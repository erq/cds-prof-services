require 'rails_helper'

describe UsersController, :type => :controller do

  describe 'show user profile' do
    before(:each) do
      @user = User.create(:id => "1")
      @user.uid = "12345" 
      session[:user_id] = "12345"
      controller.instance_variable_set(:@current_user, @user)
    end
    it 'should not let you see profile for user that doesn\'t exist' do
      get(:show, {:id => "2"})
      # expect(response).to render_template("show")
      assert_equal flash[:notice], "The user you entered does not exist."
    end
    it 'should show profile for existing user' do
      get(:show, {:id => "1"})
      expect(controller.instance_variable_get(:@user)).to eql(@user)
      expect(controller.instance_variable_get(:@own_profile)).to eql(true)
      expect(response).to render_template("show")
    end
  end

  describe 'edit user profile' do
    before(:each) do
      @user = User.create(:id => "1")
      @user.uid = "12345" 
      session[:user_id] = "12345"
      controller.instance_variable_set(:@current_user, @user)
      @user2 = User.create(:id => "2")
      @user2.uid = "67890"
    end
    it 'should render edit if no user params' do
      get(:edit, {:id => "1"}, {:user_id => "12345"})
      expect(response).to render_template("edit")
    end 
    it 'should not allow you to edit user that exists if not current user' do
      get(:edit, {:id => "2"}, {:user_id => "67890"})
      # expect(response).to render_template("show")
      assert_equal flash[:notice], "You may only edit your own profile."
    end
    it 'should not allow you to edit user that does not exist if not current user' do
      get(:edit, {:id => "3"}, {:user_id => "10296"})
      # expect(response).to render_template("show")
      assert_equal flash[:notice], "You may only edit your own profile."
    end
    it 'should redirect to edit if phone format incorrect' do
      get(:edit, {:id => "1", :user => {:phone_number => "abc"}}, {:user_id => "12345"})
      expect(response).to render_template("edit")
    end  
    it 'should redirect to edit if zipcode format incorrect' do
      get(:edit, {:id => "1", :user => {:zipcode => "1234"}}, {:user_id => "12345"})
      expect(response).to render_template("edit")
    end  

    it 'should redirect to user page if given correct params' do
      get(:edit, {:id => "1", :user => {:phone_number => "(510)123-1234"}, :status => "Looking", :availability => "All the time", :zipcode => "12345"}, {:user_id => "12345"})
      expect(response).to redirect_to user_path(:id => "1")
    end 
    it 'should update user info if given all params' do
      get(:edit, {:id => "1", :user => {:address => "387 Soda Hall", :city => "Berkeley", :zipcode => "94720", :country => "US", :description => "Hello!", :phone_number => "(510)123-1234", :status => "Looking", :availability => "All the time"}}, {:user_id => "12345"})
      @user = User.find_by_id("1")
      assert_equal @user.address, "387 Soda Hall"
      assert_equal @user.city, "Berkeley"
      assert_equal @user.zipcode, "94720"
      assert_equal @user.country, "US"
      assert_equal @user.description, "Hello!"
      assert_equal @user.phone_number, "(510)123-1234"
      assert_equal @user.status, "Looking"
      assert_equal @user.availability, "All the time"
    end 
    it 'should update user info if given some params' do
      get(:edit, {:id => "1", :user => {:description => "Hello!", :phone_number => "(510)123-1234"}}, {:user_id => "12345"})
      @user = User.find_by_id("1")
      assert_equal @user.address, nil
      assert_equal @user.city, nil
      assert_equal @user.zipcode, nil
      assert_equal @user.country, nil
      assert_equal @user.description, "Hello!"
      assert_equal @user.phone_number, "(510)123-1234"
      assert_equal @user.availability, nil
    end 
  end

  describe 'delete user profile' do
    before(:each) do
      @user = User.create(:id => "1")
      @user.uid = "12345" 
      session[:user_id] = "12345"
    end
    it 'should remove user from database' do
      controller.instance_variable_set(:@current_user, @user)
      get(:destroy, :id => "1")
      assert_equal User.all, []
    end
    it 'should nullify the user id in the session hash' do
      controller.instance_variable_set(:@current_user, @user)
      get(:destroy, :id => "1")
      assert_equal session[:user_id], nil
    end
  end

end