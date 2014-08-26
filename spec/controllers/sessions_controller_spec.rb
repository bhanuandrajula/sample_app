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

end
