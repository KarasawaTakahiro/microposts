class Micropost < ActiveRecord::Base
  belongs_to :user                      # 各投稿は特定の1人のユーザのものである
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 140}
end
