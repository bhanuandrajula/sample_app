require 'rails_helper'

RSpec.describe "FriendlyForwardings", :type => :request do
  describe "GET /friendly_forwardings" do
	before(:each) do
		@attr = {:name => "Akshu",:email=> "akshu@gmail.com", :password => "akshu@123" , :password_confirmation => "akshu@123"}
		@user = User.create!(@attr)
	end
    it " Should forward to the requested page after sigin" do
		visit edit_user_path(@user)
		fill_in "Email", :with =>@user.email
		fill_in "Password", :with => @user.password
		click_button "Sign in"
		#response.should render_template('users/edit')
	end
  end
end
