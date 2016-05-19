class UsersController < ApplicationController
  include SessionsHelper
  include BCrypt
  before_action :logged_in_user, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update]  # :editと:updateの前だけ:set_messageを実行する


  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
    @favorites = @user.favorite_microposts.order(created_at: :desc)
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
    update_params = user_params

    # パスワード変更処理
    if params[:user][:new_password] != "" && params[:user][:new_password]   # PWの変更要求
      if params[:user][:new_password] == params[:user][:new_password_confirmation]   # PWの整合性チェック
       @user = current_user
        if @user.authenticate(user_params[:password]) # 認証
          update_params[:password] = params[:user][:new_password]   # PW入れ替え
        else
          flash[:danger] = "パスワードと確認パスワードが違います"
          render 'edit' and return
        end
      else
        flash[:danger] = "パスワードが違います"
        render 'edit' and return
      end
    end
    
    if @user.update(update_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to user_path and return
    else
      @user = current_user
      render 'edit' and return
    end
  end

  def followings
    if params[:user_id]
      # 他人のfollowingsページを見てる
      @user = User.find(params[:user_id])
    else
      set_user
    end
  end

  def followers
    if params[:user_id]
      # 他人のfollowersページを見てる
      @user = User.find(params[:user_id])
    else
      set_user
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
