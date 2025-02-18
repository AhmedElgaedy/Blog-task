class User < ApplicationRecord
  has_secure_password

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
