# frozen_string_literal: true

require "#{Rails.root}/lib/sms"
include SMS
class Old::Notice < Old::ApplicationRecord
  has_many :notice_recipients, class_name: 'Old::NoticeRecipient'
  belongs_to :account, class_name: 'Old::Account'
  acts_as_paranoid
  scope :active, -> { where(active: true) }
  belongs_to :sender, class_name: 'User'
  #  belongs_to :sender
end
