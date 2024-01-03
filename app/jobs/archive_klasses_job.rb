# frozen_string_literal: true

require 'sidekiq-scheduler'

class ArchiveKlassesJob
  include Sidekiq::Worker

  def perform
    time_to_check = 3.months.ago

    obsolete_classes = Klass.working.where('updated_at < ?', time_to_check)
    obsolete_classes.each do |oc|
      next if oc.special_class?
      next if oc.meetings.working.where('updated_at > ?', time_to_check).any?
      next if oc.student_meetings.working.where('student_meetings.updated_at > ?', time_to_check).any?
      next if oc.student_classes.where('updated_at > ?', time_to_check).any?
      next if FormDetail.working.where(parent_id: oc.meetings.ids).where('updated_at > ?', time_to_check).any?

      oc.account.admins.each do |x|
        notification = x.notifications.find_or_initialize_by(record: oc, purpose: :mark_obsolete)
        notification.save unless notification.persisted?
      end
    end
  end
end
