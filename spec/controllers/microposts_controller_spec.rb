require 'rails_helper'

describe MicropostsController do
	render_views
	
	describe "Access control" do
	
	# Inorder to pass the below two tests we have to authenticate the users using before_filter in microposts_controller
	# use copy the authenticate method from users_controller to sessions_helper
		it "Should deny access to 'create'" do
			post :create
			response.should redirect_to(signin_path)
		end
		
		it "Should deny access to destroy" do
			delete :destroy, :id => 1
			response.should redirect_to(signin_path)
		end
	end
	
	describe "POST 'create'" do
	
		before(:each) do
			@user_attr = {:name => "Sriniuser",:email=> "Sriniuser@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
			@user = User.create!(@user_attr)
			test_sign_in(@user)
		end
		
		describe "failure" do
		
			before(:each) do
				@attr = {:conent => ""}
			end
			
			it "Should not create a micropost" do
				lambda do
					post :create,  :micropost => @attr
				end.should_not change(Micropost, :count)	
			end
			
			it "Should re-render the home page" do
				post :create, :micropost => @attr
				response.should render_template('pages/home')
				#response.should redirect_to(root_path)
			end
		end
		
		describe "Success" do
		
			before(:each) do
				@attr = {:content => "Bhanu's micropost content" }
			end
			
			it "Should create a micropost" do
				lambda do
					post :create, :micropost => @attr
				end.should change(Micropost, :count).by(1)
			end
			
			it "Should redirect to the rooth path " do
				post :create, :micropost => @attr
				response.should redirect_to(root_path)
			end
			
			it "Should have a flash success message" do
				post :create, :micropost => @attr
				flash[:success] =~/micropost created/i
			end
			
		end
		
		  describe "DELETE 'destroy'" do
			
			describe "for an unauthorized user" do
				before(:each) do
					@user_attr = {:name => "Sriniuser",:email=> "Sriniuser1@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
					@wronguser_attr = {:name => "wrong",:email=> "wrong1@gmail.com", :password => "srini@123" , :password_confirmation => "srini@123"}
					@micropost = {:content => "Muthu to get back soon." }
					@user = User.create!(@user_attr)
					@wronguser = User.create!(@wronguser_attr)
					test_sign_in(@wronguser)
				end
				
				it "should deny access" do
					#delete :destroy, :id => @micropost
					#response.should redirect_to(root_path)
				end
			end
			
			
			describe "for an authorized user" do
			
			
			end
		  
		  		
		

		  end
		
	end

end
