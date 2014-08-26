require 'rails_helper'

RSpec.describe "Users", :type => :request do

  describe "Sign up" do
  
	   describe "failure" do
		it "Should not make a new user" do
			visit signup_path
			fill_in "Name", :with => ""
			fill_in "Email", :with => ""
			fill_in "Password", :with => ""
			fill_in "Confirmation", :with => ""
			click_button "Sign up"
			#expect(response).to render_template('users/new')
			#response.should have_tag("div#error_explanation")
			#response.should have_
		end
	   end
	   describe "Success" do
		it "Should create a new user" do
			visit signup_path
			fill_in "Name", :with => "bhanuuser"
			fill_in "Email", :with => "bhanua1985@gmail.com"
			fill_in "Password", :with => "srini@123"
			fill_in "Confirmation", :with => "srini@123"
			click_button "Sign up"
			
		end
	   end	   
   
  end
end
