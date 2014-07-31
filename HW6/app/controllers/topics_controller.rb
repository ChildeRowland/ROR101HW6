class TopicsController < ApplicationController

	def index
		@user = User.find(params[:user_id]) 
		# I originally tried:
		# @topic = Topic.find(params[:user_id])
		# But this was only allowing for one instance of topic.  I assume because it is the foreign key and not the primary.
	end

	def show
		@user = User.find(params[:user_id])
		@topic = Topic.find(params[:id])
	end

	def new
		@user = User.find(params[:user_id])
		@topic = @user.topics.build(params[:topic])
	end

	def create
		@user = User.find(params[:user_id])
		@topic = @user.topics.build(topic_params)
		if @topic.save
			flash[:notice] = "New Topic Added"
			redirect_to user_topics_path @user
		else
			flash[:notice] = "Topic Not Added"
			redirect_to new_topic_path
		end
	end

	def edit
		@user = User.find(params[:user_id])
		@topic = Topic.find(params[:id])
		#@topic = @user.topics.build(params[:topic])
	end

	def update
		@user = User.find(params[:user_id])
		@topic = Topic.find(params[:id])
		if @topic.update_attributes(topic_params)
			flash[:notice] = "Topic Updated"
			redirect_to user_topics_path @user
		else
			flash[:notice] = "Something Went Wrong"
			redirect_to edit_user_topics_path
		end
	end

	def destroy
		if Topic.find(params[:id]).delete
			flash[:notice] = "Topic Deleted"
			redirect_to user_topics_path #@user
		else
			flash[:notice] = "There was a problem"
			redirect_to user_topics_path #@user
		end
	end

	private   
	def topic_params    
		params.require(:topic).permit(:title, :description, :user_id)   
	end

end