require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
 render_views
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

end
