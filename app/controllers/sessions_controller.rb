class SessionsController < ApplicationController
  def new
	@title= "Sign in"
  end
  
  def create
	user = User.authenticate(params[:session][:email],
							params[:session][:password])
	if user.nil?								
		flash.now[:error] = "Invalid email/password combination" # user .now to persist only for this screen
		render 'new'
	else
	#handle successful session
	
	sign_in user
	#definition of below method is written in sessions_helper.rb
	redirect_back_or(user)
	end
	
  end
  
  	def destroy
		sign_out
		redirect_to root_path
	end

   
end
