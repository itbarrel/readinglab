# frozen_string_literal: true

# == Schema Information
#
# Table name: archive_form_details
#
#  id                     :uuid             not null, primary key
#  deleted_at             :datetime
#  form_detail_created_at :datetime
#  form_detail_deleted_at :datetime
#  form_detail_updated_at :datetime
#  form_values            :jsonb
#  parent_type            :string           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  account_id             :uuid             not null
#  form_id                :uuid             not null
#  parent_id              :uuid             not null
#  user_id                :uuid
#
# Indexes
#
#  index_archive_form_details_on_account_id  (account_id)
#  index_archive_form_details_on_form_id     (form_id)
#  index_archive_form_details_on_parent      (parent_type,parent_id)
#  index_archive_form_details_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (form_id => forms.id)
#  fk_rails_...  (user_id => users.id)
#
class ArchiveFormDetail < ApplicationRecord
  belongs_to :account
  belongs_to :user, optional: true
  belongs_to :form
  belongs_to :student
  belongs_to :parent, polymorphic: true
end
