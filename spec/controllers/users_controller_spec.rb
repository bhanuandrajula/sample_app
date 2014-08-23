require 'rails_helper'
require 'factory_girl_rails'
require 'spec_helper'

RSpec.describe UsersController, :type => :controller do
 render_views
 
 	before(:each) do
	@attr = {:name => "Sriniuser",:email=> "Sriniuser@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
	end

 
 describe "Get Show" do
  		before(:each) do
			@user = User.create!(@attr)
		end
		
	it "Should be successful" do
		get :show, :id => @user
		response.should be_success
	end
	
	it "Should find the right user" do
		get :show, :id =>@user
		assigns(:user).should == @user
	end
	
	it "should have the right title" do
		get:show, :id => @user
		response.should have_title(@user.name)
	end
	
	
end

 
 
 describe "GET new" do
  
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
	
	it "Should have the right title" do
	get :new
	#response.should have_tag("title","Sign up");
	 expect(response).to render_template(:new)
	end
	
  end

end
 