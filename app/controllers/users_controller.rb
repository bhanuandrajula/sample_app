class UsersController < ApplicationController

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

  	private
	def user_params
	  params.require(:user).permit(:name, :email, :password,
								   :password_confirmation)
	end
  
end
