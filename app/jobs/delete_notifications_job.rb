# frozen_string_literal: true

require 'sidekiq-scheduler'

class DeleteNotificationsJob
  include Sidekiq::Worker

  def perform
    time_to_check = 1.month.ago

    notifications = Notification.where('seen_at < ?', time_to_check)
    notifications.delete_all
  end
end
