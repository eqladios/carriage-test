class CardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]
  before_action :set_list, only: [:index, :create]

  # GET lists/:list_id/cards
  def index
    @cards = @list.cards.left_joins(:comments).group(:id).order('COUNT(comments.id) DESC')

    render json: @cards
  end

  # GET lists/:list_id/cards/1
  def show
    # TODO there might be a smarter way
    @first_three_comments = @card.comments.limit(3)
    render json: [@card, @first_three_comments]
  end

  # POST lists/:list_id/cards
  def create
    @card = @list.cards.new(card_params)

    if @card.save
      render json: @card, status: :created, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT lists/:list_id/cards/1
  def update
    if @card.update(card_params)
      render json: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE lists/:list_id/cards/1
  def destroy
    @card.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    def set_list
      @list = List.find(params[:list_id])
    end

    # Only allow a trusted parameter "white list" through.
    def card_params
      params.require(:card).permit(:title, :description, :list_id)
    end
end
