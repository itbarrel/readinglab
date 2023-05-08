# frozen_string_literal: true

# == Schema Information
#
# Table name: payment_meetings
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  meeting_id :uuid             not null
#  payment_id :uuid             not null
#
# Indexes
#
#  index_payment_meetings_on_meeting_id  (meeting_id)
#  index_payment_meetings_on_payment_id  (payment_id)
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (payment_id => payments.id)
#
class PaymentMeeting < ApplicationRecord
  belongs_to :meeting
  belongs_to :payment
end
