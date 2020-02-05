class User < ApplicationRecord
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                          format: { with: VALID_EMAIL_REGEX },
                          uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 5 },  allow_nil: true  #allow_nil: true 対象の値がnilの場合にバリデーションをスキップ
  has_many :games, dependent: :destroy
  has_secure_password
end
