# frozen_string_literal: true

require 'sidekiq-scheduler'

class DeleteNoticeJob
  include Sidekiq::Worker

  def perform
    time_to_check = 3.months.ago

    notices = Notice.where('created_at < ?', time_to_check)
    notices.delete_all
  end
end
