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
	
	def sign_out
		cookies.delete(:remember_token)
		current_user = nil  # to do this put some code in spec_helper.rb i.e test_sign_in
	end
	
	def current_user?(user)
		user == current_user
	end
	
	def deny_access
		store_location
		redirect_to signin_path, :notice => "Please sign in to access this page."
	end
	
	# Below method is to store the location of cookies from page to page
	def store_location
		session[:return_to] = request.fullpath
	end
	
	def redirect_back_or(user)
		redirect_to(session[:return_to] || user)
		clear_return_to
	end
	
	def clear_return_to
		session[:return_to] = nil
	end
	
	private
	
	def user_from_remember_token
		User.authenticate_with_salt(*remember_token) #passing any no. of arguments so using *
		
	end
	
	def remember_token
		cookies.signed[:remember_token] || [nil,nil]
	end
end
