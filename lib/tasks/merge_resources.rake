# frozen_string_literal: true

namespace :merge do
  desc 'TODO'
  task my_task: :environment do
    Old::Account.all.each do |a|
      Account.find_or_create_by!(name: a.name, currency: a.currency, settings: a.settings, email: a.email,
                                 address: a.address, mobile: a.mobile, timezone: a.timezone, province: a.province,
                                 postal_code: a.postal_code, country_code: a.country_code,
                                 billing_scheme: a.billing_scheme, notify_emails: a.send_emails, parent_id: a.parent_id)
    end
  end
end
