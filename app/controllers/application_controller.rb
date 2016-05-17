class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper     # SessionHelperモジュールを読み込む


  private
  def logged_in_user
    # ログインしていない時に、アクセスしようとしたURLを
    # 一旦保存してログイン画面にリダイレクトする
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
