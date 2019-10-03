class BlogsController < ApplicationController

  def index
    @blogs = Blog.all
  end

  def new
    @blogs = Blog.new
  end

  def create
    Blog.create(create_params)
    redirect_to controller: :blogs, action: :index
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.update(update_params)
    end
    redirect_to controller: :blogs, action: :index
  end

  def destroy
    blog = Blog.find(params[:id])
    if blog.user_id == current_user.id
      blog.destroy
    end
    redirect_to controller: :blogs, action: :index
  end

  private
  def create_params
    params.require(:blog).permit(:name, :text).merge(user_id: current_user.id)
  end 

  def update_params
    params.permit(:text)
  end

end
