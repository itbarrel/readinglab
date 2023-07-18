# frozen_string_literal: true

require 'sidekiq-scheduler'

class DeleteNotificationsJob
  include Sidekiq::Worker

  def perform
    time_to_check = 3.months.ago

    notifications = Notification.where('seen_at < ?', time_to_check)
    notifications.destroy_all
  end
end
