class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_admin?
      can :manage, User
    else
      can :manage, User, :id => user.id
    end

    can :manage, Item, :user_id => user.id
  end
end
