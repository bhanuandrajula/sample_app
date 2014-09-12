require 'rails_helper'

RSpec.describe Relationship, :type => :model do
		# before(:each) do
			# @at1 	= {:name => "Sriniuser",:email=> "Sriniuser3@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
			# @follower = User.create!(@at1)
			# @at2 	= {:name => "Sriniuser",:email=> "Sriniuser33@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
			# @followed = User.create!(@at2)
			# @attr 		= {:followed_id => @followed_id}
		# end
		
		# it "Should create a new instance with valid attributes" do
			# @follower.relationships.create!(@attr)
		# end
		
		# describe "Follow methods" do
			# before(:each) do
				# @at1 	= {:name => "Sriniuser",:email=> "Sriniuser4@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
				# @follower = User.create!(@at1)
				# @at2 	= {:name => "Lottie Schinner",:email=> "example1-1@railstutorial.org", :password => "srini@123" , :password_confirmation => "srini@123"}
				# @followed = User.create!(@at2)
				# @attr 		= {:followed_id => @followed_id}			
				# @relationship = @follower.relationships.create!(@attr)
			# end
		
			# it "Should have a follower attribute" do
				# @relationship.should respond_to(:follower)
			# end
			
			# it "Should have the right follower" do
				# @relationship.follower.should == @follower
			# end
			
			# it "Should have a followed attribute" do
				# @relationship.should respond_to(:followed)
			# end
			
			# # it "Should have the right followed user" do
				# # @relationship.followed.should == @followed
			# # end			
		# end
		
		# describe "Validations" do
		
			# it "Should require a follower id" do
				# Relationship.new(@attr).should_not be_valid
			# end	
			
			# it "Should require a followed id" do
				# @follower.relationships.build.should_not be_valid
			# end
		# end
		
end

# == Schema Information
#
# Table name: relationships
#
#  id          :integer         not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

