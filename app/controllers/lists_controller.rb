class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy, :assign, :unassign]

  # GET /lists
  def index
    @lists = List.all

    render json: @lists
  end

  # GET /lists/1
  def show
    render json: @list, :include => :cards
  end

  # POST /lists
  def create
    @list = List.new(list_params)

    if @list.save
      render json: @list, status: :created, location: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    @list.destroy
  end

  def assign
    @user = User.find(params[:user_id])
    
    if @list.users << @user
      render json: @list, status: :created, message: "Successfully joined the list."
    else
      render json: @list.errors, status: :unprocessable_entity 
    end

    rescue ActiveRecord::RecordNotUnique
      render json: @list, status: :not_acceptable, message: 'You already joined this list!'
  end

  def unassign
    @user = User.find(params[:user_id])

    if @list.users.include?(@user)
      @list.users.destroy(@user)
      render json: @list, status: :accepted, message: "Successfully un-joined the list."
    else
      render json: @list, status: :not_acceptable, message: "User doesn't belong to list"
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def list_params
      params.require(:list).permit(:title, :cards_id, :user_id)
    end
end
