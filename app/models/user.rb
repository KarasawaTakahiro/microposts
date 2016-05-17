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
end
