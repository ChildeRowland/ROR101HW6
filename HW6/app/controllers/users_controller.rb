class UsersController < ApplicationController

	def index
		@user = User.all
		@comment = Comment.all
	end

	def show
		@user = User.find(params[:id])
	end

	def destroy
		if User.find(params[:id]).delete
			flash[:notice] = "User Deleted"
			redirect_to users_path
		else
			flash[:notice] = "There was a problem"
			redirect_to user_path @user
		end
	end

	#actions for a new user 
	def new
		@user = User.new(params[:id])
	end

	def create
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "New User Added"
			redirect_to user_path @user
		else
			flash[:notice] = "user not added"
			redirect_to new_user_path
		end
	end

	#actions for editing a user
	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params) 
			flash[:notice] = "User info updated"
			redirect_to user_path @user
		else
			flash[:notice] = "Something went wrong"
			redirect_to user_path @user
		end
	end

	private   
	def user_params     
		params.require(:user).permit(:fname, :lname, :email, :password)   
	end

end
