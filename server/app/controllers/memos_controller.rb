class MemosController < ApplicationController

  protect_from_forgery with: :null_session

  def index
    @memos = Memo.where card_id: params[:card_id]
    render json: @memos
  end

  def create
    @memo = Memo.new params.require(:memo).permit(:card_id, :content)

    if @memo.save
      render json: {
        status: :success,
        id: @memo.id
      }
    else
      render json: {
        status: error,
        erros: @memo.errors
      }
    end
  end

  def show
    @memo = Memo.find params[:id]
    render json: @memo
  end

  def update
    @memo = Memo.find params[:id]
    
    if @memo.update params.require(:memo).permit(:content)
      render json: {
        status: :success,
        id: @memo.id
      }
    else
      render json: {
        status: error,
        erros: @memo.errors
      }
    end
  end

  def destroy
    memo = Memo.find params[:id]
    memo.destroy

    render json: {
      status: :success,
      id: memo.id
    }
  end
end
