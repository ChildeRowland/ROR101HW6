class SessionsController < ApplicationController

	def create
		@user = User.where(email: params[:email]).first
		if @user && @user.password == params[:password]
			session[:user_id] = @user.id
			return redirect_to user_path @user
		else
			flash[:notice] = "Login Failed, try again"
			return redirect_to users_path
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "Logged Out"
		return redirect_to users_path
	end

end
