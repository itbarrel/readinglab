# frozen_string_literal: true

require 'sidekiq-scheduler'

class DeleteNotificationsJob
  include Sidekiq::Worker

  def perform
    time_to_check =  3.months.ago

    notifications = Notification.where('seen_at < ?', 3.month.ago)
    notifications.destroy_all
  end
end
