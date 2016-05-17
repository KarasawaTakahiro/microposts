class StaticPagesController < ApplicationController
  def home
    # current_user.microposts.build == Micropost.new(user_id: current_user.id)
    # current_userのhas_many :micropostsで生成されるbuildメソッドを使っている
    # user_idが紐付いてくる
    @micropost = current_user.microposts.build if logged_in?
  end
end
