class CardsController < ApplicationController

  protect_from_forgery with: :null_session

  def index
    @cards = Card.where get_conditions params
    p @cards
    render json: @cards
  end

  def create
    @card = Card.new params.require(:card).permit(:title, :card_group_id)

    if @card.save
      render json: {
        status: :success,
        id: @card.id
      }
    else
      render json: {
        status: error,
        erros: @card.errors
      }
    end
  end

  def show
    @card = Card.find params[:id]
    render json: @card
  end

  def update
    @card = Card.find params[:id]
    
    if @card.update params.require(:card).permit(:title, :description)
      render json: {
        status: :success,
        id: @card.id
      }
    else
      render json: {
        status: error,
        erros: @card.errors
      }
    end
  end

  def destroy
    card = Card.find params[:id]
    card.destroy

    render json: {
      status: :success,
      id: card.id
    }
  end

  private 

    def get_conditions (params)

      conditions = []
      if params['card_group_id'].present?
        conditions.push "card_group_id = #{params['card_group_id']}"
      end
      if params['created_at_from'].present?
        conditions.push "DATE(created_at) >= '" + Date.parse(params['created_at_from']).to_s + "'"
      end
      if params['created_at_to'].present?
        conditions['created_at <='] = Date.parse(params['created_at_to']).to_time
      end

      p conditions;

      conditions
    end
end
