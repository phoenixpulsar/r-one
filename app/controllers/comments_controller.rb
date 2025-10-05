class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.build(params.expect(comment: [:content]))
    @comment.user = current_user
    @comment.save!
    redirect_to @post
  end

  private
    def set_post
      @post = Post.find(params[:post_id])
    end
end
