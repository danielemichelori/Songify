class CommentsController < ApplicationController
 before_action :authenticate_user!

  def new
  	super
  end

  def create
  	@comment = Comment.new
  	@comment.artist = params[:artist]
  	@comment.user = current_user
  	@comment.body = params[:body]
  	@comment.save
  	redirect_to artist_path(id: params[:artist]), :notice => "Commented."
  end

  def show 
  	@comments =Comment.all
  end

  def destroy
    @comment = Comment.find(params[:id])
    @artist = @comment.artist 
    @comment.destroy
  	redirect_to artist_path(id: @artist), :notice => "Comment removed."
  end

  def like
  	@comment = Comment.find(params[:id])
  	x = @comment.like.to_i + 1
    @comment.update_attribute(:like, x)
  	redirect_to artist_path(id: params[:artist]), :notice => "Comment liked."
  end

  def dislike
  	@comment = Comment.find(params[:comment_id])
  	c = @comment.dislike.to_i + 1
    @comment.update_attribute(:dislike, c)
  	redirect_to artist_path(id: params[:artist]), :notice => "Comment disliked."
  end

  private
  def comment_params
  	params.require(:comment).permit(:body, :artist, :user_id, :like, :dislike)
  end
end
