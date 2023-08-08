# frozen_string_literal: true

require 'sidekiq-scheduler'

class ArchiveObsoleteKlassesJob
  include Sidekiq::Worker

  def perform
    klasses = Klass.obsolete.where('obsoleted_at > ?', 3.months.ago)
    klasses.each do |klass|
      ArchiveKlass.find_or_create_by!(
        id: klass.id,
        klass_deleted_at: klass.deleted_at,
        duration: klass.duration,
        friday: klass.friday,
        max_students: klass.max_students,
        min_students: klass.min_students,
        monday: klass.monday,
        range_type: klass.range_type,
        saturday: klass.saturday,
        session_range: klass.session_range,
        starts_at: klass.starts_at,
        sunday: klass.sunday,
        thursday: klass.thursday,
        tuesday: klass.tuesday,
        wednesday: klass.wednesday,
        klass_created_at: klass.created_at,
        klass_updated_at: klass.updated_at,
        account_id: klass.account&.id,
        attendance_form_id: klass.attendance_form&.id,
        klass_template_id: klass.klass_template&.id,
        room_id: klass.room&.id,
        teacher_id: klass.teacher&.id
      )
      klass.meetings.each do |meeting|
        ArchiveMeeting.find_or_create_by!(
          id: meeting.id,
          cancel: meeting.cancel,
          meeting_deleted_at: meeting.deleted_at,
          ends_at: meeting.ends_at,
          hold: meeting.hold,
          starts_at: meeting.starts_at,
          meeting_created_at: meeting.created_at,
          meeting_updated_at: meeting.updated_at,
          account_id: meeting.account&.id,
          archive_klass_id: meeting.klass&.id
        )
        meeting.form_details.each do |fd|
          ArchiveFormDetail.find_or_create_by!(
            id: fd.id,
            form_detail_deleted_at: fd.deleted_at,
            form_values: fd.form_values,
            parent_type: fd.parent_type,
            submitted: fd.submitted,
            form_detail_created_at: fd.created_at,
            form_detail_updated_at: fd.updated_at,
            account_id: fd.account&.id,
            form_id: fd.form&.id,
            parent_id: fd.parent&.id,
            student_id: fd.student&.id,
            user_id: fd.user&.id
          )
          klass.student_meetings.each do |sm|
            ArchiveStudentMeeting.find_or_create_by!(
              id: sm.id,
              attendance: sm.attendance,
              student_meeting_deleted_at: sm.deleted_at,
              student_meeting_created_at: sm.created_at,
              student_meeting_updated_at: sm.updated_at,
              account_id: sm.account&.id,
              archive_meeting_id: sm.meeting&.id,
              student_id: sm.student&.id
            )
          end
        end
      end
    end
  end
end
