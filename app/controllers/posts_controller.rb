class PostsController < ApplicationController

  
  # GET /posts/new
  def new
    @post = Post.new
  end

  # POST /posts
  # POST /posts.json
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
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:image, :text_color, :upper_text, :lower_text)
    end


end
