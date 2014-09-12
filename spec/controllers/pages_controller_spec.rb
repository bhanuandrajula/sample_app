require 'rails_helper'
require 'spec_helper'

RSpec.describe PagesController, :type => :controller do
 render_views

  describe "GET home" do
  
  
    it "returns http success" do
      get :home
      expect(response).to be_success
    end
	 
	it "should have a non blank body" do
      get :home
      expect(response).not_to match(/<body>\s*<\/body>/)
    end
	
	  # describe "follower/following counts" do
		# let(:user) { FactoryGirl.create(:user) }
        # let(:other_user) { FactoryGirl.create(:user) }
        # before do
          # other_user.follow!(user)
          # visit root_path
        # end

        # it { should have_link("0 following", href: following_user_path(user)) }
        # it { should have_link("1 followers", href: followers_user_path(user)) }
      # end

  end
    
  describe "GET contact" do
    it "returns http success" do
      get :contact
      expect(response).to be_success
    end
  end
  
  describe "GET about" do
    it "returns http success" do
      get :about
      expect(response).to be_success
    end
  end
  
  describe "GET help" do
    it "returns http success" do
      get :help
      expect(response).to be_success
    end
  end
end
