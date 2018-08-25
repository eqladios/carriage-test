class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true
    has_many :comments, as: :commentable 
    scope :firstthree, -> { order('id').limit(3) }
    belongs_to :user
    belongs_to :list
end
