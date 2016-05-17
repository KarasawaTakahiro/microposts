class UsersController < ApplicationController
  include SessionsHelper
  before_action :logged_in_user, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]  # :editと:updateの前だけ:set_messageを実行する


  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id    # セッションを登録
      flash[:success] = "ようこそ！AccountのSettingからプロフィールを登録しましょう！"
      # routes.rb で resources:users
      # を設定してあるので redirect_to user_path(@user) に等しい
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to user_path
    else
      @user = current_user
      render 'edit'
    end
  end


  private

  def user_params
    # :password と :password_confirmation は has_secure_password で提供される
    params.require(:user).permit(:name, :email, :password, :password_confirmation,
                                 :profile, :place, :homepage, :birthday)
  end

  def set_user
    @user = current_user
  end
end
