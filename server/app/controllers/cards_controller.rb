class CardsController < ApplicationController

  protect_from_forgery with: :null_session

  def index
    @cards = Card.where get_conditions params
    render json: @cards
  end

  def create
    @card = Card.new params.require(:card).permit(:title)

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

      p params
      conditions = []
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
