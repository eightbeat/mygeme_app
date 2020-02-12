class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "ゲームレビューにようこそ!"
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user_games = @user.games.paginate(page: params[:page], per_page: 5)
  end

  def edit

  end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    if !@user.admin?
      @user.destroy
      flash[:danger] = "ユーザーと関連する全てのレビューを削除しました。"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user and !current_user.admin?
      flash[:danger] = "管理者しか編集できません。"
      redirect_to users_path
    end
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "この操作が管理者しかできません。"
      redirect_to root_path
    end
  end
end
