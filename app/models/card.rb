class Card < ApplicationRecord
    has_many :comments, as: :commentable 
    belongs_to :list
end
