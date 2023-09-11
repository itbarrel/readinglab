# frozen_string_literal: true

Honeybadger.configure do |config|
  config.api_key = ENV['HONEYBADGER_API_KEY']
end
