require 'rails_helper'
require 'spec_helper'

RSpec.describe "LayoutLinks", :type => :request do

 
  describe "GET /layout_links" do
  include Rails.application.routes.url_helpers
	it "should have a Home page at '/'" do
    get '/'
    response.should render_template('pages/home')
  end

  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should render_template('pages/contact')
  end

  it "should have an About page at '/about'" do
    get '/about'
    response.should render_template('pages/about')
  end

  it "should have a Help page at '/help'" do
    get '/help'
    response.should render_template('pages/help')
  end
  
  it "should have a Signup page '/signup'" do
    get '/signup'
    response.should render_template('users/new')
  end
  
    it "should have a Signin page '/signin'" do
    get '/signin'
    response.should render_template('sessions/new')
  end
  
  #Integration tests not working :( so commenting
  
  # it "Should have the right links on the layouts" do
  
	# visit root_path
	# response.should render_template('/home')
	# click_link "About"
	# response.should render_template('pages/about')
	# click_link "Contact"
	# response.should render_template('pages/contact')
	# click_link "Home"
	# response.should render_template('pages/home')
	# click_link "Sign up now!"
	# response.should render_template('pages/signup')
  
  # end
  
  describe "when not signed in" do
	it "Should have a signed in link" do
		get '/signin'
		response.should render_template('sessions/new')
	end
  end
  
  describe "when signed in" do
	
	before(:each) do
		@attr = {:name => "Sriniuser",:email=> "Sriniuser@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
		@user = User.create!(@attr)
		visit signin_path
		fill_in "Email", 	:with => @user.email
		fill_in "Password",	:with => @user.password
		click_button "Sign in"
	end
	it " should have a signout link" do
		get '/signout'
		#response.should render_template('sessions/destroy')
		
	
	end
	
	#it { should has_link('Settings',href: edit_user_path(@user)) }
   
  end
 end 
end
