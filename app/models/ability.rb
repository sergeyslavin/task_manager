class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_admin?
      can :manage, User
    end

    can :manage, Item, :user_id => user.id
  end
end
