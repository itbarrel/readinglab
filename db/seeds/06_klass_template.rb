# frozen_string_literal: true

KlassTemplate.find_or_create_by!(
  name: 'zareen',
  monday: true,
  tuesday: true,
  wednesday: false,
  thursday: false,
  friday: false,
  saturday: false,
  sunday: false,
  user: User.last,
  account: Account.last
)
