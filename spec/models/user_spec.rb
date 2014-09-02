require 'rails_helper'

RSpec.describe User, :type => :model do

	before(:each) do
	@attr = {:name => "Sriniuser",:email=> "Sriniuser@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}

	end
  #pending "add some examples to (or delete) #{__FILE__}"
	it "Should create a new instance" do
	 User.create!(@attr)
	end

	it "Should have the name" do
	 #no_name_user = User.new(:email=>"noname@gmail.com")
	 no_name_user = User.new(@attr.merge(:name=>""))
	 no_name_user.should_not be_valid
	end
	
	it "Should have the email address" do
		#no_email_address = User.new(:name=>"noemail@gmail.com")
		no_email_address = User.new(@attr.merge(:email=>""))
		no_email_address.should_not be_valid
	end	
	
	it "Should reject the names longer than 50" do
		long_name = "a" *56
		long_name_user = User.create(@attr.merge(:name=>long_name))
		long_name_user.should_not be_valid
	end
	
	it "Should accept valid email Address" do
		addresses=%w[bhanu@foo.com user@foo.bar.org bans@foo.jp];
		addresses.each do |address|
		valid_email_user = User.create(@attr.merge(:email => address))
		valid_email_user.should be_valid
		end
	end
	
	it "Should not accpet  invalid email Address" do
		addresses=%w[bhanu@foo,com user.foo.bar.org banswipro.foo.jp];
		addresses.each do |address|
		invalid_email_user = User.create(@attr.merge(:email => address))
		invalid_email_user.should_not be_valid
		end
	end
	
	it "Should reject the duplicate email id" do
		User.create!(@attr)	#Creating the user in the database
		user_with_dup_email = User.new(@attr) # Creating the user in the memory
		user_with_dup_email.should_not be_valid
	end
	
	it "Should reject the email address identical to upcase" do
		upcase_email = @attr[:email].upcase
		User.create!(@attr.merge(:email => upcase_email))
		user_with_dup_email = User.new(@attr)
		user_with_dup_email.should_not be_valid
	end
	
	describe "passwords" do
		before(:each) do
			@user = User.new(@attr)
		end
		
		it "Should have a password" do
			@user.should respond_to(:password)
		end
		
		it "Should have password confirmation" do
			@user.should respond_to(:password_confirmation)
		end
	end
	
	describe "password validations" do
		it "Should have a password" do
			User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
		end
		
		it "should require matching password confirmation" do
			User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
		end
		
		it "Should reject short passwords" do
			short = "a" * 5
			hash = @attr.merge(:password => short, :password_confirmation =>short)
			User.new(hash).should_not be_valid
		end
		
		it "Should reject long passwords" do
			long = "a" * 41
			hash = @attr.merge(:password => long, :password_confirmation =>long)
			User.new(hash).should_not be_valid
		end
		
	end
	
	describe "Password encryption" do
		before(:each) do
			@user = User.create!(@attr)
		end
				
		it "should have an encrypted password" do
			@user.should respond_to(:encrypted_password)
		end

		it "should set the encrypted password" do
			@user.encrypted_password.should_not be_blank
		end
		
		it "Should have a salt" do
			@user.should respond_to(:salt)
		end
		
	end
	
	describe "has_password method" do
	
		before(:each) do
			@user = User.create!(@attr)
		end
	
		it "Should exists" do
			@user.should respond_to(:has_password?)
		end
		
		it "Should return true if the password match" do
			@user.has_password?(@attr[:password]).should be_truthy
		end
		
		it "Should return false if the password doesnot match" do
			@user.has_password?("invalid").should be_falsey
		end
			
	end
	
	describe "authenticate method" do
	  
	   before(:each) do
	     @user = User.create!(@attr)
	   end
	   
	   it "Should exists" do
	     User.should respond_to(:authenticate)
	     
	   end
	   it "Should return nil on email/password mismatch" do
	     User.authenticate(@attr[:email],"wrongpass").should be nil
	   end
	   
	   it "Should return nil for an email address with no user" do
	     User.authenticate("bar@foot.com",@attr[:password]).should be nil
	   end
	   
	   it "should return the user on email/pass match" do
	     User.authenticate(@attr[:email],@attr[:password]).should == @user
	     
	   end
	  
	end
	
	describe "Admin attribute" do
	
		before(:each) do
			@user = User.create!(@attr)
		end
	
		it "Should respond to admin" do
			@user.should respond_to(:admin)
		
		end
		it "Should not be admin by default" do
			@user.should_not  be_admin
		
		end
		it "Should be convertiable to an admin" do
			@user.toggle!(:admin)
			@user.should be_admin
		
		end
	end
	
	describe User do

	  before do
		@user = User.new(name: "Example User", email: "user@example.com",
						 password: "foobar", password_confirmation: "foobar")
	  end
			
	  it { should respond_to(:admin) }
	  it { should respond_to(:microposts) }
	  
	    describe "micropost associations" do

			before { @user.save }
			let!(:older_micropost) do
			  FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
			end
			let!(:newer_micropost) do
			  FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
			end

			it "should have the right microposts in the right order" do
			  expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
			end
			
			# it "Should destory the associated microposts" do
				# microposts = @user.microposts.to_a
				# expect(microposts).not_to be_empty
					# microposts.each do |micropost|
						# expect(Micropost.where(id: micropost.id)).to be_empty
					# end
			# end
	   	end	
	end	
end





# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean
#

