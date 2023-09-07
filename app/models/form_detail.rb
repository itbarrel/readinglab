# frozen_string_literal: true

# == Schema Information
#
# Table name: form_details
#
#  id           :uuid             not null, primary key
#  deleted_at   :datetime
#  form_values  :jsonb
#  obsolete     :boolean          default(FALSE)
#  obsoleted_at :datetime
#  parent_type  :string           not null
#  submitted    :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :uuid             not null
#  form_id      :uuid             not null
#  parent_id    :uuid             not null
#  student_id   :uuid             not null
#  user_id      :uuid             not null
#
# Indexes
#
#  index_form_details_on_account_id  (account_id)
#  index_form_details_on_form_id     (form_id)
#  index_form_details_on_parent      (parent_type,parent_id)
#  index_form_details_on_student_id  (student_id)
#  index_form_details_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (form_id => forms.id)
#  fk_rails_...  (user_id => users.id)
#
class FormDetail < ApplicationRecord
  belongs_to :account
  belongs_to :user, optional: true
  belongs_to :form
  belongs_to :student
  belongs_to :parent, polymorphic: true

  scope :obsolete, -> { where obsolete: true }
  scope :working, -> { where obsolete: false }

  validates :form_values, presence: true, allow_blank: true

  before_validation :default_form_values
  after_save :set_parent_status
  after_create :mark_attendance
  after_save :handle_obsolete, if: :saved_change_to_obsolete?

  def default_form_values
    self.form_values ||= {}
  end

  def self.to_csv(options = {})
    student = options[:student]

    CSV.generate(headers: true) do |csv|
      csv << [student.name, '', student.parent.name]
      csv << []
      all.group_by(&:form).each do |form, values|
        csv << ['Meeting date', 'Form Name', 'Form Sumbmission Date', *form.form_fields.order(:id).map(&:name)]
        values.each do |fd|
          csv << [fd.parent.starts_at.strftime('%Y-%m-%d %H:%M:%p'),
                  form.name, fd.created_at.strftime('%Y-%m-%d %H:%M:%p'),
                  *form.form_fields.order(:id).map do |x|
                    fd.form_values[x.model_key]
                  end]
        end
      end
      csv << []
    end
  end

  private

  def set_parent_status
    return unless parent.is_a?(Interview)

    parent.done!
    return unless parent.student.scheduled?

    student.wait_listed!
  end

  def handle_obsolete
    obsolete_time = obsolete? ? Time.zone.now : nil

    update(obsoleted_at: obsolete_time)
  end

  def mark_attendance
    return unless parent_type == 'Meeting'

    StudentMeeting.find_or_create_by!(
      account_id:,
      student_id:,
      meeting_id: parent_id
    ).update(attendance: :present)
  end
end
