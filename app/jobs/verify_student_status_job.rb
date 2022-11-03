# frozen_string_literal: true

class VerifyStudentStatusJob
  include Sidekiq::Worker

  def perform
    Interview.select { |x| x.date > Date.new }.update
  end
end
