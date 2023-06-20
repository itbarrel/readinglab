# frozen_string_literal: true

require 'sidekiq-scheduler'

class ArchiveKlassesJob
  include Sidekiq::Worker

  def perform
    obsolete_classes = Klass.where('updated_at < ?', 6.months.ago)
    obsolete_classes.each do |oc|
      next if oc.meetings.where('updated_at > ?', 6.months.ago).any?
      next if FormDetail.where(parent_id: oc.meetings.ids).where('updated_at > ?', 6.months.ago).any?
      # oc.update()
    end
  end
end
