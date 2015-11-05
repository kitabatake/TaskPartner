class TodosController < ApplicationController

  protect_from_forgery with: :null_session

  def index
    @todos = Todo.where card_id: params[:card_id]
    render json: @todos
  end

  def create
    @todo = Todo.new params.require(:todo).permit(:card_id, :content)

    if @todo.save
      render json: {
        status: :success,
        id: @todo.id
      }
    else
      render json: {
        status: error,
        erros: @todo.errors
      }
    end
  end

  def show
    @todo = Todo.find params[:id]
    render json: @todo
  end

  def update
    @todo = Todo.find params[:id]
    
    if @todo.update params.require(:todo).permit(:content, :done)
      render json: {
        status: :success,
        id: @todo.id
      }
    else
      render json: {
        status: error,
        erros: @todo.errors
      }
    end
  end

  def destroy
    todo = Todo.find params[:id]
    todo.destroy

    render json: {
      status: :success,
      id: todo.id
    }
  end
end
