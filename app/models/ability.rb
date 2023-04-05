# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Handle the case where we don't have a current_user i.e. the user is a guest
    # user ||= User.new

    # Define a few sample abilities
    can :manage, :all if user.super_admin?

    return unless user.admin?

    can :manage, Book, account_id: user.account_id
    can :manage, City, account_id: user.account_id
    can :manage, ContentLibrary, account_id: user.account_id
    can :manage, Form, account_id: user.account_id
    can :manage, FormField, account_id: user.account_id
    can :manage, Interview, account_id: user.account_id
    can :manage, KlassTemplate, account_id: user.account_id
    can :manage, Klass, account_id: user.account_id
    can :manage, Meeting, account_id: user.account_id
    can :manage, MessageTemplate, account_id: user.account_id
    can :manage, Parent, account_id: user.account_id
    can :manage, ReceiptType, account_id: user.account_id
    can :manage, Receipt, account_id: user.account_id
    can :manage, Room, account_id: user.account_id
    can :manage, Student, account_id: user.account_id
    can :manage, User, account_id: user.account_id
    can :manage, TrajectoryDetail, account_id: user.account_id
    can :manage, VacationType, account_id: user.account_id
    can :manage, Vacation, account_id: user.account_id
    can :manage, StudentMeeting, account_id: user.account_id

    can :manage, FormField, { form: { account_id: user.account_id } }

    can :manage, StudentClass, { student: { account_id: user.account_id }, klass: { account_id: user.account_id } }
    can :manage, KlassForm, { klass: { account_id: user.account_id }, form: { account_id: user.account_id } }
    can :manage, KlassTemplateForm, { klass_template: { account_id: user.account_id }, form: { account_id: user.account_id } }
    can :manage, StudentForm, { student: { account_id: user.account_id }, form: { account_id: user.account_id } }
  end
end
