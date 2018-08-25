class User < ApplicationRecord
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist
  enum role: [:admin, :member]
  has_many :memberships
  has_many :lists, through: :memberships
  has_many :cards
  has_many :comments
end