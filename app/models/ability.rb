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

    elsif user.member?
      
      can [:manage], List do |list|
        list.users.include?(user)
      end
      
      can [:manage], Card

      can [:read], Comment do |comment|
        user.lists.include?(comment.list)
      end

      can [:update], Comment, user_id: user.id 

      can [:destroy], Comment do |comment|
        @reply_on_own_comment = comment.commentable.is_a?(Comment) and comment.commentable.user == user
        comment.user == user or @reply_on_own_comment
      end

      can [:create], Comment #Check hard-coded in Create method

    end

  end
end
