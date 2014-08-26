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
	flash[:success] = "welcome to Bhanu's App"
	if @user.save
	#puts "Inside save"
	redirect_to user_path(@user)
		# Handle a succesfull save
	else
		#puts "Inside else"
		@title = "Sign up"
		render 'new'
	end	

  end

  	private
	def user_params
	  params.require(:user).permit(:name, :email, :password,
								   :password_confirmation)
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
