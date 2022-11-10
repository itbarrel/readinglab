# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Handle the case where we don't have a current_user i.e. the user is a guest
    user ||= User.new

    # Define a few sample abilities
    can    :manage, Account
    cannot :manage, City
    can    :read, User, released: true
  end
end