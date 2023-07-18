# frozen_string_literal: true

# == Schema Information
#
# Table name: notifications
#
#  id          :uuid             not null, primary key
#  deleted_at  :datetime
#  purpose     :integer
#  record_type :string           not null
#  seen_at     :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  record_id   :uuid             not null
#  user_id     :uuid             not null
#
# Indexes
#
#  index_notifications_on_record   (record_type,record_id)
#  index_notifications_on_user_id  (user_id)
#  notification_index              (record_id,record_type,user_id,purpose,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :record, polymorphic: true

  enum :purpose, %i[creation mark_obsolete]

  def text
    case purpose
    when :creation, 'creation'
      record_type.to_s
    when :mark_obsolete, 'mark_obsolete'
      'System has proposed a class'
    end
  end

  def description
    case purpose
    when :creation, 'creation'
      "has been created on #{created_at.strftime('%H:%M %p-%d-%h-%Y')}"
    when :mark_obsolete, 'mark_obsolete'
      ' to mark obsolete'
    end
  end

  def affirmative
    mark_as_seen
    case purpose
    when :creation, 'creation'
      true
    when :mark_obsolete, 'mark_obsolete'
      # record.update(obsolete: true)
      {
        modal_file: 'shared/modals/klasses/details',
        params: { klass: record, title: 'Details' }
      }
    end
  end

  def negative
    mark_as_seen
    case purpose
    when :creation, 'creation'
      true
    when :mark_obsolete, 'mark_obsolete'
      true
    end
  end

  def seen?
    seen_at.present?
  end

  def self.seen_all?
    where(seen_at: nil).any?
  end

  def mark_as_seen
    update(seen_at: Time.zone.now)
  end
end
