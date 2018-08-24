class CardsController < ApplicationController
  before_action :set_card, only: [:update, :destroy]

  # GET /cards
  def index
    @cards = Card.left_joins(:comments).group(:id).order('COUNT(comments.id) DESC')

    render json: @cards
  end

  # GET /cards/1
  def show
    # TODO there might be a smarter way
    @card = Card.find(params[:id])
    @first_three_comments = @card.comments.limit(3)
    render json: [@card, :first_three_comments => @first_three_comments]
  end

  # POST /cards
  def create
    @card = Card.new(card_params)

    if @card.save
      render json: @card, status: :created, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  def update
    if @card.update(card_params)
      render json: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1
  def destroy
    @card.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def card_params
      params.require(:card).permit(:title, :description)
    end
end
