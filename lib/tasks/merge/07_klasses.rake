# frozen_string_literal: true

namespace :merge do
  desc 'Merges klasses to new tables'
  task klasses: :environment do
    range_types = {
      sessions: 'sessional',
      monthly: 'monthly'
    }
    templates = {}

    KlassTemplate.all.each do |x|
      templates[x.id] = true
    end

    Old::RClass.find_each(batch_size: 200) do |old_klass|
      Klass.find_or_create_by!(
        starts_at: old_klass.start,
        session_range: old_klass.session_range,
        account_id: old_klass.account_id,
        teacher_id: old_klass.teacher.id,
        room_id: old_klass.room.id
      ) do |klass|
        klass.skip_validations = true
        klass.id = old_klass.id
        klass.klass_template_id = old_klass.class_template_id if templates[old_klass.class_template_id].present?
        klass.attendance_form_id = Form.where(name: Form.default_seeds).first
        klass.monday = old_klass.monday
        klass.tuesday = old_klass.tuesday
        klass.wednesday = old_klass.wednesday
        klass.thursday = old_klass.thursday
        klass.friday = old_klass.friday
        klass.saturday = old_klass.saturday
        klass.sunday = old_klass.sunday
        klass.duration = old_klass.duration.to_i / 60
        klass.min_students = old_klass.min_students
        klass.max_students = old_klass.max_students
        klass.range_type = range_types[old_klass.range_type]
        klass.created_at = old_klass.created_at
        klass.updated_at = old_klass.updated_at
        klass.deleted_at = (old_klass.active)? old_klass.deleted_at : old_klass.updated_at
      end
    end
    puts 'Successfully Merged klasses.'
  end
end
