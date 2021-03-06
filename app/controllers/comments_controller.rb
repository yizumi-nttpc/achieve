class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create

    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    @notification = @comment.notifications.build(user_id: @blog.user.id )

    respond_to do |format|

      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.js { render :index }

        set_pusher
        update_pusher

      else
        format.html { render :index }
      end

    end

  end

  def edit
    @blog = @comment.blog
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params) then
        format.html { redirect_to blog_path(@comment.blog), notice: 'コメントを更新しました。' }
        format.js { render :index }
      else
        format.html { redirect_to blog_path(@comment.blog), notice: 'コメントを更新しませんでした。' }
        format.js { render :index }
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

    def set_pusher
      unless @comment.blog.user_id == current_user.id
        Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {
          message: 'あなたの作成したブログにコメントが付きました'
        })
      end
    end

    def update_pusher
      Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
        unread_counts: Notification.where(user_id: @comment.blog.user.id, read: false).count
      })
    end

end
