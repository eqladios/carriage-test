class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]
  before_action :set_commentable, only: [:index, :create]
  load_and_authorize_resource :comment
  
  # GET /:commentable/:commentable_id/comments
  def index
    @comments = @commentable.comments
    paginate json: @comments, per_page: 10
  end

  # GET /:commentable/:commentable_id/comments/1
  def show
    render json: @comment, :include => :comments
  end

  # POST /:commentable/:commentable_id/comments
  def create
    if current_user.member? and !current_user.lists.include?(@commentable.list)
      raise CanCan::AccessDenied.new("Not authorized!", :create, Comment)
    end
    
    @comment = @commentable.comments.new(comment_params)

    @comment.user = current_user
    if @commentable.is_a?(Card)
      @comment.list = @commentable.list
    elsif @commentable.is_a?(Comment)
      @comment.list = @commentable.list
    end

    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /:commentable/:commentable_id/comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /:commentable/:commentable_id/comments/1
  def destroy
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_commentable
      @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
      @commentable = Card.find_by_id(params[:card_id]) if params[:card_id]
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:content,:comment_id,:card_id)
    end
end
