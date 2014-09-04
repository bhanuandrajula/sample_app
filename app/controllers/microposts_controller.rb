class MicropostsController < ApplicationController
	
	before_filter :authenticate
	before_filter :correct_user, :only => :destroy # this is used to authorize the user before destroying it
	
	def create
		@micropost = current_user.microposts.build(micropost_params)
		
		if @micropost.save
			redirect_to root_path, :flash => {:success => "Micropost created"}
		else
			#@feed_items = current_user.feed.paginate(:page => params[:page])
			@feed_items = []
			render 'pages/home'
		end	
	
	end
	
	def destroy
		@micropost.destroy
		redirect_to root_url, :flash =>{:success => "Post deleted."}
	end
	
	private
	
	def correct_user
		#@micropost = current_user.microposts.find_by(id: params[:id])
		@micropost = Micropost.find(params[:id])
		redirect_to root_path unless current_user?(@micropost.user)
	end
	
	def micropost_params
      params.require(:micropost).permit(:content)
    end
	
end
