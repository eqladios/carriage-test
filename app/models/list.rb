class List < ApplicationRecord
  has_many :cards, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
end
