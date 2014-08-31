class UsersController < ApplicationController
	
	#The below line is to authenticate the user if the user is trying to edit or update the profile
	
	before_filter :authenticate, :only => [:edit, :update]
	
  def show
	#@user = User.find(1)
	@user = User.find(params[:id])
	@title = @user.name
  end
  
  def new
	@user = User.new
    @title = "Sign up"
  end
  
  def create

	@user = User.new(user_params)
	
	if @user.save
		sign_in @user
		redirect_to user_path(@user), :flash => {:success => "welcome to Bhanu's App"}
	else
		@title = "Sign up"
		render 'new'
	end	

  end
  
  def edit
	@user = User.find(params[:id])
	@title = "Edit user"
  end
  
  def update
	@user = User.find(params[:id])
	if @user.update_attributes(user_params)
	 #it worked
		redirect_to user_path(@user) , :flash => {:success => "Profile updated"}
	else 
		@title = "Edit user"
		render 'edit'
	end	
  end
  

  	private
	def user_params
	  params.require(:user).permit(:name, :email, :password,
								   :password_confirmation)
	end
	
	def authenticate
		#flash[:notice] = "Please sign in to access this page."
		deny_access unless signed_in? #this method deny_access is written in sessions_helper to be generic
	end
  
end
