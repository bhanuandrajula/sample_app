require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

 	before(:each) do
	@attr = {:name => "Sriniuser1",:email=> "Sriniuser1@gmail.com", :password => "srini1@123" , :password_confirmation => "srini1@123"}
	end


  describe "GET new" do
  
  			before(:each) do
				@user = User.create!(@attr)
			end
	
	
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
	it "Should have the right title" do
		get :new
		expect(response).to render_template(:new)
	end
		
  end
  
  describe "POST 'create'" do
	describe "failure" do
		before(:each) do
			@attr = {:email => "", :password => ""}
		end
		
		it "Should have the right title" do
			post :create, :session =>@attr
			response.should render_template(:new)
		end	
		
		it "Should re-render the new page" do
			post :create, :session =>@attr
			response.should render_template('new')
		end
				
		it "Should have an error message" do
			post :create, :session => @attr
			flash.now[:error].should =~ /invalid/i
		end
	end
	

	describe "Success" do
	
		before(:each) do
			#@user = User.create!(@attr)
			@attr1 = {:name => "Sriniuser1",:email => "Sriniuser@gmail.com", :password => "srini@123"}
			@user = User.create!(@attr1)
		end
		
		it "Should sign in the user" do
			post :create, :session =>@attr1
			#fill in with tests for sign in user
			controller.current_user.should == @user
			controller.should be_signed_in
		end
		
		it "Should redirect to the user show page" do
			post :create, :session =>@attr1
			response.should redirect_to(user_path(@user))
		end
		
	end
	
	
  end	
  
  describe "Delete 'Destroy'" do 
  		before(:each) do
			#@user = User.create!(@attr)
			@attr1 = {:name => "Sriniuser1",:email => "Sriniuser@gmail.com", :password => "srini@123"}
			@user = User.create!(@attr1)
		end
	it "Should sign a user out" do
		test_sign_in(@user)
		delete :destroy
		controller.should_not be_signed_in
		response.should redirect_to(root_path)
		
	end
	
  end
end
