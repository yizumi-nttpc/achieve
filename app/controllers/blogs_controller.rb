class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:edit, :update, :destroy]

  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def create
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blogs_path, notice: "ブログを作成しました！"
      NoticeMailer.sendmail_blog(@blog).deliver
    else
      render 'new'
    end
  end

  def edit
  end
 
  def update
    if @blog.user_id == current_user.id then
      if @blog.update(blogs_params) then
        redirect_to blogs_path, notice: "ブログを更新しました！"
      else
        redirect_to blogs_path, notice: "ブログを更新しませんでした"
      end
    else
      redirect_to blogs_path, notice: "プログを更新できません"
    end
  end

  def destroy
    if @blog.user_id == current_user.id then
      @blog.destroy
      redirect_to blogs_path, notice: "ブログを削除しました！"
    else
      redirect_to blogs_path, notice: "ブログを削除できません"
    end
  end

  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end

private
  def blogs_params
    params.require(:blog).permit(:title, :content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

end
