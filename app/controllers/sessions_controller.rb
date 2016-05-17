class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "logged in as #{@user.name}"

      if session[:forwarding_url]
        # ログインが必要なページから飛ばされていたら、目的のページに移動する
        forward = session[:forwarding_url]
        session[:forwarding_url] = nil
        redirect_to forward
      else
        redirect_to @user
      end
    else
      flash[:danger] = 'ログインに失敗しました！ メールアドレスとパスワードを確認してください'
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
