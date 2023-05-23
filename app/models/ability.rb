# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def admin_permissions_for(user)
    can :read, :communication
    can :read, :reports
    can :read, :billing
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
    can :manage, StudentForm, { student: { account_id: user.account_id }, form: { account_id: user.account_id } }
    can :manage, Payment,
        { student: { account_id: user.account_id }, meeting: { account_id: user.account_id }, receipt: { account_id: user.account_id } }
  end

  def supervisor_permissions_for(user)
    can :read, :communication
    can :read, :reports
    can :read, :billing
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
    can :manage, StudentForm, { student: { account_id: user.account_id }, form: { account_id: user.account_id } }
  end

  def initialize(user)
    # Handle the case where we don't have a current_user i.e. the user is a guest
    # user ||= User.new

    # Define a few sample abilities
    return if user.blank?

    can :manage, :all if user.super_admin?

    admin_permissions_for user if user.admin?

    supervisor_permissions_for user if user.supervisor?

    return unless user.teacher?

    can :read, Klass, { teacher_id: user.id, account_id: user.account_id }
    can :edit, Klass, { teacher_id: user.id, account_id: user.account_id }
    can :manage, Meeting, { klass: { teacher_id: user.id, account_id: user.account_id } }
  end
end
