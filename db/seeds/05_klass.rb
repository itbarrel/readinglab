# frozen_string_literal: true

Klass.find_each do |x|
  x.destroy
end

teacher = Teacher.last

Klass.find_or_create_by!(
  starts_at: Time.now,
  duration: 60,
  monday: true,
  tuesday: true,
  wednesday: true,
  thursday: true,
  friday: true,
  saturday: true,
  sunday: true,
  teacher: teacher,
  room: Room.last,
  klass_template: KlassTemplate.last,
  account: Account.last
)
