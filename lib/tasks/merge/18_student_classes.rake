# frozen_string_literal: true

namespace :merge do
  desc 'Merges student_classes to new tables'
  task student_classes: :environment do
    klasses = {}

    Klass.all.each do |x|
      klasses[x.id] = true
    end

    students = {}

    Student.all.each do |x|
      students[x.id] = true
    end

    Old::StudentClass.find_each(batch_size: 100) do |old_student_class|
      next unless klasses[old_student_class.r_class_id] && students[old_student_class.student_id]

      StudentClass.find_or_create_by!(
        klass_id: old_student_class.r_class_id,
        student_id: old_student_class.student_id
      ) do |student_class|
        student_class.id = old_student_class.id
        student_class.created_at = old_student_class.created_at
        student_class.updated_at = old_student_class.updated_at
        student_class.deleted_at = old_student_class.deleted_at
      end
    end
    puts 'Successfully Merged Student Classes.'
  end
end
