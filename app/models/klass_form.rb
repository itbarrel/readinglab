# frozen_string_literal: true

# == Schema Information
#
# Table name: klass_forms
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  form_id    :uuid             not null
#  klass_id   :uuid             not null
#
# Indexes
#
#  index_klass_forms_on_form_id   (form_id)
#  index_klass_forms_on_klass_id  (klass_id)
#  klass_forms_id                 (klass_id,form_id,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (form_id => forms.id)
#  fk_rails_...  (klass_id => klasses.id)
#
class KlassForm < ApplicationRecord
  belongs_to :form
  belongs_to :klass

  has_many :student_forms, dependent: :destroy
end
