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
		expect(response).to render_template(:show)
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
  
  describe "POST 'Create'" do
  
	describe "Failure" do
		before(:each) do
			@attr ={:name =>"", :email => "", :password => "", :password_confirmation => ""}
		end
		
		it " Should have the right title" do 
			post :create, :user=>@attr
			expect(response).to render_template(:new)
		end
		
		it " Should render the new page" do
			post :create, :user=>@attr
			expect(response).to render_template('new')
		
		end
		
		it " Should not create a new user" do
			lambda do
				post :create, :user=>@attr
			end.should_not change(User, :count)
		end
	end
	
	describe "Success" do
	
		before(:each) do
			@attr = {:name => "New User" , :email => "newuser@gmail.com" , :password => "newpass" , :password_confirmation => "newpass"}
		end
		
		it "Should create a user" do
			lambda do
				post :create, :user=>@attr
			end.should change(User, :count).by(1)
		end
		
		it "Should redirect the user show page" do
			post :create, :user=>@attr
			response.should redirect_to(user_path(assigns(:user)))
		end
		
		it "Should have a welcome message" do
			post :create, :user =>@attr
			flash[:success].should =~ /welcome to Bhanu's App/i
		end
		
		it "Should sign the user in" do
			post :create, :user =>@attr
			controller.should be_signed_in
		end
		
	
	end
	
  end  
  
  describe "Get Edit" do
		before(:each) do
			@attr = {:name => "Sriniuser",:email=> "Sriniuser@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
			@user = User.create!(@attr)
			test_sign_in(@user)
		end
		
		it "Should be successful" do
			get :edit, :id => @user
			response.should be_success
			#expect(response).to be_success
		end
		
		it "Should have the right title" do
			get :edit, :id =>@user
			expect(response).to render_template(:edit)
		end
		
	  #it { should have_content("Update your profile") }
      #it { should have_title("Edit user") }
      #it { should have_link('change', href: 'http://gravatar.com/emails') }
		 
		# it "Should have a link to change the gravitor" do
			# get :edit, :id =>@user
			
  end
  
  describe "Put update" do
		before(:each) do
			@attr = {:name => "Sriniuser",:email=> "Sriniuser@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
			@user = User.create!(@attr)
			test_sign_in(@user)
		end
		
	describe "failure" do
		before(:each) do
			@attr = {:name => "",:email=> "", :password => "" , :password_confirmation => ""}
		end
		
		it "Should render the edit page" do
			put :update, :id=>@user, :user => @attr
			expect(response).to render_template(:edit)
			
		end
		
		it "Should have the right title" do
			put :update, :id=>@user, :user => @attr
			#expect(response).to render_template(:update)
		end
		
	end
	
	describe "Success" do
		before(:each) do
			@attr = {:name => "Akshu",:email=> "akshu@gmail.com", :password => "akshu@123" , :password_confirmation => "akshu@123"}
		end
		
		it "Should change the users attributes" do
			put :update, :id=>@user, :user => @attr
			user = assigns(:user) 
			@user.reload
			@user.name.should == user.name
			@user.email.should == user.email
			@user.encrypted_password.should  == user.encrypted_password
			
		end
		
		it "Should have a flash message" do
			put :update, :id=>@user, :user => @attr
			flash[:success].should =~ /updated/i
			
		end
		
		
	end
	
  end

end
 