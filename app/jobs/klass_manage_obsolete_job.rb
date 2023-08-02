# frozen_string_literal: true

require 'sidekiq-scheduler'

class KlassManageObsoleteJob
  include Sidekiq::Worker

  def perform(klass_id)
    klass = Klass.find(klass_id)

    obsolete_time = klass.obsolete? ? Time.zone.now : nil
    meetings_to_handle = klass.obsolete? ? klass.meetings.working : klass.meetings.obsolete

    klass.update(obsoleted_at: obsolete_time)
    meetings_to_handle.each do |x|
      x.update(obsolete: klass.obsolete?)
    end

    klass.student_classes.destroy_all if klass.obsolete?
  end
end
