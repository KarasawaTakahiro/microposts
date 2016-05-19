class FavoritesController < ApplicationController
    def create
        # fav する micropost_id を受け取る
        @micropost = Micropost.find(params[:micropost_id])
        current_user.favorite(@micropost)
    end

    def destroy
        # micropost を現在のユーザから外す
        @micropost = Micropost.find(params[:micropost_id])
        current_user.unfavorite(@micropost)
    end
end
