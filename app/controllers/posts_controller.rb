class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.image = Meme.new(params[:post][:image].tempfile.path, @post.text_color, @post.upper_text, @post.lower_text).store_meme

    if @post.save
      redirect_to confirm_path(@post)
    else
      render 'posts#new'
    end 

  end


  def confirm
    @post = Post.find_by(id: params[:id])
  end


  def download
    @post = Post.find_by(id: params[:id])
    data = open @post.image, "r"

    send_data data.read, filename: @post.image.split("/").last
  end


  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:image, :text_color, :upper_text, :lower_text)
    end


end
