class RelationshipsController < ApplicationController
    before_action :logged_in_user

    def create
        # フォローする他のユーザのIDをパラメータで受け取って見つかったユーザをfollowする
        @user = User.find(params[:followed_id])
        current_user.follow(@user)
    end

    def destroy
        # 自分がフォローしているユーザのIDを取り出して、unfollowに渡す
        @user = current_user.following_relationships.find(params[:id]).followed
        current_user.unfollow(@user)
    end
end
