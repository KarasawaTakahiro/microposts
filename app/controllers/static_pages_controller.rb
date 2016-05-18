class StaticPagesController < ApplicationController
  def home
    # current_user.microposts.build == Micropost.new(user_id: current_user.id)
    # current_userのhas_many :micropostsで生成されるbuildメソッドを使っている
    # user_idが紐付いてくる
    #@micropost = current_user.microposts.build if logged_in?
    if logged_in?
      @micropost = current_user.microposts.build
      # .includes(:user) でつぶやきのユーザ情報を先読みしておく
      # これにより、@feed_items からアイテムを取り出すたびにユーザ情報をDBから取り出さずに済む
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
end
