class User < ApplicationRecord
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable
  devise :database_authenticatable,
         :jwt_authenticatable,
         jwt_revocation_strategy: JWTBlacklist
end