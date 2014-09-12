require 'rails_helper'
require 'factory_girl_rails'
require 'spec_helper'

RSpec.describe UsersController, :type => :controller do
 render_views
 
 	before(:each) do
	@attr = {:name => "Sriniuser",:email=> "Sriniuser@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
	end
	
	describe "GET 'index'" do
		describe "For non- signed in users" do
			it "Should deny access" do
				get :index
				response.should redirect_to(signin_path)
			end
		end
		describe "For signed in users" do
			before(:each) do
				@attr = {:name => "Sriniuser",:email=> "Sriniuser@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
				@attr1 = {:name => "Sriniuser1",:email=> "Sriniuser1@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
				@attr2 = {:name => "Sriniuser2",:email=> "Sriniuser2@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
				@user = User.create!(@attr)
				@user1 = User.create!(@attr1)
				@user2 = User.create!(@attr2)
				test_sign_in(@user)
			end
			it "Should allow access" do
				get :index
				response.should be_success
			end
			
			it "Should have the right title" do
				get :index
				expect(response).to render_template(:index)
			end
			
			it "Should have a delete link for admin users" do
				@user.toggle!(:admin)
				other_user = User.all.second
				#get :index
				#response should have 
			end
			
		end
  end
  
 
 describe "Get Show" do
  		before(:each) do
			@user = User.create!(@attr)
		end
		
	let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }	
		
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
	
      # it { should have_content(m1.content) }
      # it { should have_content(m2.content) }
      # it { should have_content(user.microposts.count) }
		
	
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
	describe "Authentication of edit/update pages" do
		before(:each) do
			@attr = {:name => "Akshu",:email=> "akshu@gmail.com", :password => "akshu@123" , :password_confirmation => "akshu@123"}
			@user = User.create!(@attr)
		end
		describe "For non- signed in users" do
			it "Should deny access to edit page" do
					get :edit, :id=>@user
					response.should redirect_to(signin_path)
					flash[:notice].should =~ /sign in/i
			end
			
			it "Should deny access to update page" do
					put :edit, :id=>@user, :user => {}
					response.should redirect_to(signin_path)
			end			
		end
		
		describe "For signed in users" do
		before(:each) do
			@attr = {:name => "wrong",:email=> "wrong@gmail.com", :password => "akshu@123" , :password_confirmation => "akshu@123"}
			@wronguser = User.create!(@attr)
			test_sign_in(@wronguser)
		end
		
			it "Should require matching users for edit" do
				get :edit, :id=>@user
				response.should redirect_to(root_path)
			end
			it "Should require matching users for update" do
				put :update, :id=>@user , :user => {}
				response.should redirect_to(root_path)
			end
			
		end

	end
	
	describe " Delete 'destroy'" do
		before(:each) do
			@attr = {:name => "wrong",:email=> "wrong@gmail.com", :password => "akshu@123" , :password_confirmation => "akshu@123"}
			@user = User.create!(@attr)
		end
		
		describe " as a non-signed in user" do
			it "Should deny access" do
				delete :destroy , :id=> @user
				response.should redirect_to(signin_path)
			end
		end
		
		describe " A non-Admin user" do
			it "Should protect the action" do
				test_sign_in(@user)
				delete :destroy, :id => @user
				response.should redirect_to(root_path)
			end
		end
		
		describe "As an admin user" do	
		
			before(:each) do
				
			end
			
			it "Should destroy the user" do
			end
			
			it "Should redirect to the users page" do
			end
			
			it "Should not be able to destroy itself" do
			end
		end
		
	end
	
	describe "follow pages" do
		describe "When not signed in" do
		
			it "Should protect 'following'" do
				get:following, :id => 1
				response.should redirect_to(signin_path)
			end

			it "Should protect 'followers'" do
				get:followers, :id => 1
				response.should redirect_to(signin_path)
			end
			
		end
	end

end
 