# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Handle the case where we don't have a current_user i.e. the user is a guest
    # user ||= User.new

    # Define a few sample abilities
    can :manage, :all if user.super_admin?

    return unless user.admin?

    can :manage, Book, account: user.account
    can :manage, City, account: user.account
    can :manage, ContentLibrary, account: user.account
    can :manage, Form, account: user.account
    can :manage, FormField, account: user.account
    can :manage, Interview, account: user.account
    can :manage, KlassTemplate, account: user.account
    can :manage, Klass, account: user.account
    can :manage, Meeting, account: user.account
    can :manage, MessageTemplate, account: user.account
    can :manage, Parent, account: user.account
    can :manage, ReceiptType, account: user.account
    can :manage, Receipt, account: user.account
    can :manage, Room, account: user.account
    can :manage, Student, account: user.account
    can :manage, User, account: user.account
    can :manage, TrajectoryDetail, account: user.account
    can :manage, VacationType, account: user.account
    can :manage, Vacation, account: user.account
    can :manage, StudentMeeting, account: user.account

    can :manage, FormField, { form: { account_id: user.account_id } }

    can :manage, StudentClass, { student: { account_id: user.account_id }, klass: { account_id: user.account_id } }
    can :manage, KlassForm, { klass: { account_id: user.account_id }, form: { account_id: user.account_id } }
    can :manage, KlassTemplateForm, { klass_template: { account_id: user.account_id }, form: { account_id: user.account_id } }
    can :manage, StudentForm, { student: { account_id: user.account_id }, form: { account_id: user.account_id } }
  end
end
