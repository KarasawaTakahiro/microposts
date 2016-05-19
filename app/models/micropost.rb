class Micropost < ActiveRecord::Base
  belongs_to :user                      # 各投稿は特定の1人のユーザのものである
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}

  has_many :favorited_relationships, class_name: "Favorite", foreign_key: "micropost_id", dependent: :destroy
  has_many :favoriteds, through: :favorited_relationships, source: :user_id

  # favる
  def favorite(user)
    favorited_relationships.find_or_create_by(user_id: user.id)
  end

  # favやめ
  def unfavorite(user)
    favorited_relationship = favorited_relationships.find(user_id: user.id)
    favorited_relationships.destroy if favorited_relationship
  end

  # favられているか
  def favorited?(user)
    favorited_relationships.find_by(user_id: user.id)
  end
end
