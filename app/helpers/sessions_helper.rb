module SessionsHelper
    def current_user
        # 値がなければDBからユーザ情報を取ってくる
        @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
        !!current_user
    end

    def store_location
        # GETリクエストの時にリクエストURLを代入する
        # ログインが必要なページにアクセスした時に、
        # ページのURL一旦保存して、ログイン後にリダイレクトする
        session[:forwarding_url] = request.url if request.get?
    end
end