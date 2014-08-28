module SessionsHelper

	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt] #salt is added to encrypt the user
		current_user = user
	end
	
	def current_user=(user)
		@current_user = user
	end
	
	def current_user
		@current_user ||= user_from_remember_token
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	private
	
	def user_from_remember_token
		User.authenticate_with_salt(*remember_token) #passing any no. of arguments so using *
		
	end
	
	def remember_token
		cookies.signed[:remember_token] || [nil,nil]
	end
end
