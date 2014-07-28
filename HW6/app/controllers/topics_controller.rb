class TopicsController < ApplicationController

	def index
		@user = User.find(params[:user_id])  
		# I originally tried:
		# @topic = Topic.find(params[:user_id])
		# But this was only allowing for one instance of topic.  I assume because it is the foreign key and not the primary.
	end

	def new
		@user = User.find(params[:user_id])
		@topic = @user.topics.build(params[:topic])
	end

	def create
		@topic = @user.topics.build(params[:topic])
		if @topic.save
			flash[:notice] = "New Topic Added"
			redirect_to user_path @user
		else
			flash[:notice] = "Topic Not Added"
			redirect_to new_topic_path
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private   
	def topic_params    
		params.require(:topic).permit(:title, :description)   
	end

end