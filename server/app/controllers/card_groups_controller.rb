class CardGroupsController < ApplicationController

  protect_from_forgery with: :null_session

  def index
    @card_groups = CardGroup.where get_conditions params
    render json: @card_groups
  end

  def create
    p params
    @card_group = CardGroup.new params.require(:card_group).permit(:title)

    if @card_group.save
      render json: {
        status: :success,
        id: @card_group.id
      }
    else
      render json: {
        status: error,
        erros: @card_group.errors
      }
    end
  end

  def show
    @card_group = CardGroup.find params[:id]
    render json: @card_group
  end

  def update
    @card_group = CardGroup.find params[:id]
    
    if @card_group.update params.require(:card_group).permit(:title)
      render json: {
        status: :success,
        id: @card_group.id
      }
    else
      render json: {
        status: error,
        erros: @card_group.errors
      }
    end
  end

  def destroy
    card_group = CardGroup.find params[:id]
    card_group.destroy

    render json: {
      status: :success,
      id: card_group.id
    }
  end

  private 

    def get_conditions (params)
      conditions = []
      conditions
    end
end
