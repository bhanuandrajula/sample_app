class UsersController < ApplicationController

  def show
	#@user = User.find(1)
	@user = User.find(params[:id])
  end
  
  def new
  @title = "Sign up"
  end
  

  
  
  
  # def create
    # @user = User.new(user_params) ## Invoke user_params method
    # if @user.save
      # redirect_to @user, notice: 'User was successfully created.' 
    # else
      # render action: 'new'
    # end       
  # end
  # ## ... 

  # private
  # ## Strong Parameters 
  # def user_params
  # validates_presence_of(:name)
    # params.require(:user).permit(:name, :email)
  # end
  
end
