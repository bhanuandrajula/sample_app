require 'rails_helper'

RSpec.describe User, :type => :model do

	before(:each) do
	@attr = {:name => "Sampleuser", :email=> "Sampleuser@gmail.com"}

	end
  #pending "add some examples to (or delete) #{__FILE__}"
	it "Should create a new instance" do
	 User.create!(:name => "Bhanu", :email=>"akshu@gmail.com")
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
end


# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

