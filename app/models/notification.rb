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
      "System has proposed this #{record_id}"
    end
  end

  def description
    case purpose
    when :creation, 'creation'
      "has been created on #{created_at}"
    when :mark_obsolete, 'mark_obsolete'
      ' to mark obsolete, approve?'
    end
  end

  def affirmative
    case purpose
    when :creation, 'creation'
      "has been created on #{created_at}"
    when :mark_obsolete, 'mark_obsolete'
      record.update(obsolete: true)
    end
    mark_as_seen
  end

  def negative
    case purpose
    when :creation, 'creation'
      "has been created on #{created_at}"
    when :mark_obsolete, 'mark_obsolete'
      1 + 1
    end
    mark_as_seen
  end

  def seen?
    seen_at.present?
  end

  def mark_as_seen
    update(seen_at: Time.zone.now)
  end
end
