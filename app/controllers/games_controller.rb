class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @games = Game.paginate(page: params[:page], per_page: 5)
  end

  def show

  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user = current_user
    if @game.save
      flash[:success] = "レビューを投稿しました。"
      redirect_to game_path(@game)
    else
      render 'new'
    end
  end

  def edit

  end

  def update
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

  def set_game
    @game = Game.find(params[:id])
  end

  def require_same_user
    if current_user != @game.user and !current_user.admin?
      flash[:danger] = "このレビューは編集できません。"
      redirect_to games_path
    end
  end
end
