class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    if user.admin?
      
      can [:create, :read], [List, Card, Comment]

      can [:update, :destroy, :assign, :unassign], List do |list|
        @membership = list.memberships.first
        @membership.user == user and @membership.owner
      end

      can [:update, :destroy], Card do |card|
        card.user == user or user.lists.include?(card.list)
      end

      can [:update, :destroy], Comment do |comment|
        comment.user == user or user.lists.include?(comment.list)
      end

    end

  end
end
