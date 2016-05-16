class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      # routes.rb で resources:users
      # を設定してあるので redirect_to user_path(@user) に等しい
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    # :password と :password_confirmation は has_secure_password で提供される
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
