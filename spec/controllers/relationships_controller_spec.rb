require 'rails_helper'
require 'spec_helper'

RSpec.describe RelationshipsController, :type => :controller do

	describe "access control" do
	
		it "Should require signin for create" do
			post :create
			response.should redirect_to(signin_path)
		end
		
		it "Should require signin for destroy" do
			post :destroy, :id => 1
			response.should redirect_to(signin_path)
		end
		
	end
	
	

end
