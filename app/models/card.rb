class Card < ApplicationRecord
    has_many :comments, as: :commentable
end
