class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def create

    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
#    @notification = @comment.notifications.build(user_id: @blog.user.id )

    respond_to do |format|

      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.js { render :index }

      else
        format.html { render :new }
      end

    end

  end

  def destroy

    respond_to do |format|
      @comment.destroy
      format.html { redirect_to blog_path(@blog), notice: 'コメントを削除しました。' }
      format.js { render :index }
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end

    def set_comment
      @comment = current_user.comments.find(params[:id])
    end
end
