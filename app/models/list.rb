class List < ApplicationRecord
  has_many :cards
  has_many :memberships
  has_many :users, through: :memberships
end
