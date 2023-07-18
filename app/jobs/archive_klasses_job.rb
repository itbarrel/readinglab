# frozen_string_literal: true

require 'sidekiq-scheduler'

class ArchiveKlassesJob
  include Sidekiq::Worker

  def perform
    time_to_check = 3.months.ago

    obsolete_classes = Klass.working.where('updated_at < ?', time_to_check)
    obsolete_classes.each do |oc|
      next if oc.meetings.working.where('updated_at > ?', time_to_check).any?
      next if oc.student_meetings.working.where('student_meetings.updated_at > ?', time_to_check).any?
      next if oc.student_classes.where('updated_at > ?', time_to_check).any?
      next if FormDetail.working.where(parent_id: oc.meetings.ids).where('updated_at > ?', time_to_check).any?

      users = oc.account.users.where(role: :admin)
      users ||= oc.account.users.where(role: :super_visor) if users.empty?

      users.each do |x|
        x.notifications.create!(record: oc, purpose: :mark_obsolete)
      end
    end
  end
end
