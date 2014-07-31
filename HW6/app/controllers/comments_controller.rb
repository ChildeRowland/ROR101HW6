class CommentsController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@topic = Topic.find(params[:topic_id])
	end

	def new
		@user = User.find(params[:user_id])
		@topic = Topic.find(params[:topic_id])
		@comment = @topic.comments.build(params[:comment])
	end

	def create

		#user_id not passing in the controller, right now I'm using a hidden form vaule...
		#redirect to working, no topic id?

		@user = User.find(params[:user_id])
		@topic = Topic.find(params[:topic_id])
		@comment = @topic.comments.build(comment_params)
		if @comment.save
			flash[:notice] = "Boom. Posted"
			redirect_to user_topic_comments_path
		else
			flash[:notice] = "Something Went Wrong"
			redirect_to new_user_topic_comment @user
		end
	end

	def edit
		@user = User.find(params[:user_id])
		@topic = Topic.find(params[:topic_id])
		@comment = Comment.find(params[:id])
	end

	def update
		@user = User.find(params[:user_id])
		@topic = Topic.find(params[:topic_id])
		@comment = Comment.find(params[:id])
		if @comment.update_attributes(comment_params)
			flash[:notice] = "Comment Updated"
			redirect_to user_topic_comments_path
		else
			flash[:notice] = "Someting Went Wrong"
			redirect_to user_path @user
		end
	end

	def destroy
		if Comment.find(params[:id]).delete
			flash[:notice] = "Comment Deleted"
			redirect_to user_topic_comments_path
		else
			flash[:notice] = "Something Went Wrong"
			redirect_to user_path @user
		end
	end

	private
	def comment_params    
		params.require(:comment).permit(:body, :user_id)   
	end

end
