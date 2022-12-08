# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Handle the case where we don't have a current_user i.e. the user is a guest
    # user ||= User.new

    # Define a few sample abilities
    if user.super_admin?
      can :manage, :all
    else
      user.admin?
      can :read, :all
    end
  end
end
