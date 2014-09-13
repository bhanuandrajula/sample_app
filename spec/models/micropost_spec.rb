require 'rails_helper'

RSpec.describe Micropost, :type => :model do
  describe Micropost do
	before(:each) do
		@user_attr = {:name => "Sriniuser",:email=> "Sriniuser@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
		@user = User.create!(@user_attr)
		@attr = {:content => "Bhanu's microposts"}
	end
	 let(:user) { FactoryGirl.create(:user) }
	  before do
		# This code is not idiomatically correct.
		@micropost = Micropost.new(content: "Bhanu's microposts", user_id: user.id)
	  end

	# it "Should create a new instance with valid attributes" do
		# Micropost.create!(@attr)
	# end
		it { should respond_to(:content) }
		it { should respond_to(:user_id) }
  end
  
  describe "Validations" do
  
  	# before(:each) do
		# @user_attr = {:name => "Sriniuser",:email=> "Sriniuser@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
		# @user = User.create!(@user_attr)
		# @attr = {:content => "Bhanu's microposts", :user_id => @user.id}
	# end
	  before do
		# This code is not idiomatically correct.
		@micropost = Micropost.new(content: "Bhanu's microposts", user_id: user.id)
	  end
  
	   # describe "when user_id is not present" do
		 # before { @micropost.user_id = nil }
		 # it { should_not be_valid }
		# end

	  # describe "with blank content" do
		# before { @micropost.content = " " }
		# it { should_not be_valid }
	  # end

	  # describe "with content that is too long" do
		# before { @micropost.content = "a" * 141 }
		# it { should_not be_valid }
	  # end
	
  end
  
  describe "from_users_followed_by" do
  
	  before(:each) do
	  
	  	 @firstuser_attr = {:name => "Srini1user",:email=> "Srini1user@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
		 @seconduser_attr = {:name => "Srini2user",:email=> "Srini2user@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
		 @thirduser_attr = {:name => "Srini3user",:email=> "Srini3user@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
		 @firstuser = User.create!(@firstuser_attr)
		 @seconduser = User.create!(@seconduser_attr)
		 @thirduser = User.create!(@thirduser_attr)
		 
		 @firstuserpost = @firstuser.microposts.create!(:content => "foo")
		 @seconduserpost = @seconduser.microposts.create!(:content => "bar")
		 @thirduserpost = @thirduser.microposts.create!(:content => "baz")
		 
		 @firstuser.follow!(@seconduser)

	  end
	
	it "Should have a from_users_followed_by method" do
		Micropost.should respond_to(:from_users_followed_by)
	end
	
	it "Should include followed users micropost" do
		Micropost.from_users_followed_by(@firstuser).should include(@seconduserpost)
	end
	
	it "Should include the own micropost" do
		Micropost.from_users_followed_by(@firstuser).should include(@firstuserpost)
	end
	
	it "Should not include the non followed users  micropost" do
		Micropost.from_users_followed_by(@firstuser).should_not include(@thirduserpost)
	end
	
  end
end

# == Schema Information
#
# Table name: microposts
#
#  id         :integer         not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

