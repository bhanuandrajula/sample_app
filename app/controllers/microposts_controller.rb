class MicropostsController < ApplicationController
	
	before_filter :authenticate
	
	def create
		@micropost = current_user.microposts.build(micropost_params)
		
		if @micropost.save
			redirect_to root_path, :flash => {:success => "Micropost created"}
		else
			render 'pages/home'
		end	
	
	end
	
	def destroy
	
	end
	
	private
	
	def micropost_params
      params.require(:micropost).permit(:content)
    end
	
end
