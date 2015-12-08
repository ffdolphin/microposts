class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
					  format: { with: VALID_EMAIL_REGEX },
					  uniqueness: { case_sensitive: false }
	has_secure_password

  validates :profile , length: { maximum: 255 }
  # 内容は必須入力かつ2文字以上30文字以下
  validates :area , length: { maximum: 255 }
  #0以上の数字のみ
  validates :website , length: { maximum: 255 }
end
