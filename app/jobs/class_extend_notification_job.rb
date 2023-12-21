# frozen_string_literal: true

require 'sidekiq-scheduler'

class ClassExtendNotificationJob
  include Sidekiq::Worker

  def perform
    time = Time.zone.now
    Meeting.group(:klass_id).maximum(:starts_at).select { |_x, y| y > time && y < time + 1.week }.each_key do |klass_id|
      klass = Klass.find(klass_id)
      klass.account.admins.each do |x|
        notification = x.notifications.find_or_initialize_by(record: klass, purpose: :extend_class)
        notification.save unless notification.persisted?
      end
    end
  end
end
