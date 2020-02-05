class GamesController < ApplicationController

  def index
    @games = Game.paginate(page: params[:page], per_page: 5)
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      flash[:success] = "レビューを投稿しました。"
      redirect_to game_path(@game)
    else
      render 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @recipe.update(game_params)

    else
      render 'edit'
    end
  end

  def destroy
    Game.find(params[:id]).destroy
    flash[:success] = "レビューを削除しました。"
    redirect_to games_path
  end

  private

  def game_params
    params.require(:game).permit(:name, :description, :score)
  end
end
