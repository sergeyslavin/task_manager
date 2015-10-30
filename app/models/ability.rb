class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    alias_action :update, :destroy, :to => :ud_admin

    if user.is_admin?
      can :manage, User
      can :manage, Item
      # cannot :ud_admin, Item
    else
      can :manage, Item, :user_id => user.id
      can :manage, User, :user_id => user.id
    end
  end
end
