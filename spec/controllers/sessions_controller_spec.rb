require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "GET new" do
	
    it "returns http success" do
      get :new
      expect(response).to be_success
    end
	it "Should have the right title" do
		get :new
		expect(response).to render_template(:new)
	end
		
  end
  
  describe "POST 'create'" do
	describe "failure" do
		before(:each) do
			@attr = {:email => "", :password => ""}
		end
		
		it "Should have the right title" do
			post :create, :session =>@attr
			response.should render_template(:new)
		end	
		
		it "Should re-render the new page" do
			post :create, :session =>@attr
			response.should render_template('new')
		end
				
		it "Should have an error message" do
			post :create, :session => @attr
			flash.now[:error].should =~ /invalid/i
		end
	end
  end	
end
