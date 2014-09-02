require 'rails_helper'

RSpec.describe Micropost, :type => :model do
  describe Micropost do
	# before(:each) do
		# @user_attr = {:name => "Sriniuser",:email=> "Sriniuser@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
		# @user = User.create!(@user_attr)
		# @attr = {:content => "Bhanu's microposts"}
	# end
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

