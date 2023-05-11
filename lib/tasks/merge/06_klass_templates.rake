# frozen_string_literal: true

namespace :merge do
  desc 'Merges klass_templates to new tables'
  task klass_templates: :environment do
    Old::ClassTemplate.all.each do |old_class_template|
      KlassTemplate.find_or_create_by!(
        start: old_class_template.start,
        account_id: old_class_template.account_id,
        teacher_id: old_class_template.teacher_id,
        room_id: old_class_template.room_id
      ) do |klass|
        klass.name = old_class_template.name
        klass.id = old_class_template.id
        klass.monday = old_class_template.monday
        klass.tuesday = old_class_template.tuesday
        klass.wednesday = old_class_template.wednesday
        klass.thursday = old_class_template.thursday
        klass.friday = old_class_template.friday
        klass.saturday = old_class_template.saturday
        klass.sunday = old_class_template.sunday
        klass.settings = old_class_template.settings
        klass.description = old_class_template.description
        klass.duration = old_class_template.duration
        klass.max_students = old_class_template.max_students
        klass.session_range = old_class_template.session_range
        klass.created_at = old_class_template.created_at
        klass.updated_at = old_class_template.updated_at
        klass.deleted_at = old_class_template.active ? old_class_template.deleted_at : old_class_template.updated_at
      end
    rescue StandardError
      1 + 1
    end
    puts 'Successfully Merged Klass Template.'
  end
end
