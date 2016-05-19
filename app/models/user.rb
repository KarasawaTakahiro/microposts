class User < ActiveRecord::Base
    before_save { self.email = self.email.downcase }            # アルファベットを小文字に
    validates :name, presence: true, length: {maximum: 50}      # 空でなく最大50文字
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i    # メアドの正規表現
    validates :email, presence: true, length: {maximum: 255},   # からでなく255文字以内
                      format: {with: VALID_EMAIL_REGEX},        # 正規表現にマッチ
                      uniqueness: {case_sensitive: false}       # ユニーク
    validates :profile, length: {maximum: 1000}
    validates :place, length: {maximum: 30}
    validates :homepage, length: {maximum: 255}
    has_secure_password
    has_many :microposts        # 各ユーザは複数の投稿を所持できる

    # has_many method_name でメソッドが勝手に登録される
    # user.following_relationships で user がフォローしている人を取れる
    has_many :following_relationships, class_name: "Relationship",
                                       foreign_key: "follower_id",  # user の id が入っている
                                       dependent: :destroy
    # following_relationships の followed を参照して follower で user を取り出す
    has_many :following_users, through: :following_relationships, source: :followed

    has_many :follower_relationships, class_name:  "Relationship",
                                      foreign_key: "followed_id",
                                      dependent:   :destroy
    has_many :follower_users, through: :follower_relationships, source: :follower

    # fav
    # Favorite クラス(モデル)の user_id と一致するものたち
    has_many :favorite_relationships, class_name: "Favorite", foreign_key: "user_id", dependent: :destroy
    # 上の :favorites に含まれる、 :micropost を返す
    has_many :favorite_microposts, through: :favorite_relationships, source: :micropost


    # 他のユーザをフォローする
    def follow(other_user)
        # パラメータに一致するものがあれば返して、なければ作る
        following_relationships.find_or_create_by(followed_id: other_user.id)
    end

    # フォローしているユーザをアンフォローする
    def unfollow(other_user)
        following_relationship = following_relationships.find_by(followed_id: other_user.id)
        following_relationship.destroy if following_relationship    # あったら削除する
    end

    # あるユーザをフォローしているかどうか?
    def following?(other_user)
        following_users.include?(other_user)
    end

    # フォローしているユーザ＋自分のつぶやきを取得する
    def feed_items
        Micropost.where(user_id: following_user_ids + [self.id])
    end

    # fav をつける
    def favorite(micropost)
        # references を作る
        favorite_relationships.find_or_create_by(micropost_id: micropost.id)
    end

    # fav をやめる
    def unfavorite(micropost)
        favorite_relationship = favorite_relationships.find_by(micropost_id: micropost.id)
        favorite_relationship.destroy if favorite_relationship
    end

    # favしているか
    def favorite?(micropost)
        favorite_microposts.include?(micropost)
    end
end
