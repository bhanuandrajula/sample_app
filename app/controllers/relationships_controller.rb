class RelationshipsController < ApplicationController
	
	before_filter :authenticate
	
	def create
		#raise params.inspect
		@user = User.find(params[:relationship][:followed_id])
		current_user.follow!(@user)
		#below code is for the case of ajax
		# respond_to do |format|
			# format.html {redirect_to @user}
			# format.js
		# end
		redirect_to @user
	
	end
	
	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		#below code is for the case of ajax
		# respond_to do |format|
			# format.html {redirect_to @user}
			# format.js
		# end
		redirect_to @user
	end
end
