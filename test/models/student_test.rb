# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id                :uuid             not null, primary key
#  credit_session    :integer
#  dates             :string
#  deleted_at        :string
#  dob               :date
#  first_name        :string
#  grade             :string
#  last_name         :string
#  prepaid_sessions  :integer
#  programs          :string
#  registration_date :datetime
#  school            :string
#  settings          :jsonb
#  sex               :string
#  status            :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :uuid             not null
#  parent_id         :uuid             not null
#
# Indexes
#
#  index_students_on_account_id  (account_id)
#  index_students_on_parent_id   (parent_id)
#  students_name                 (account_id,first_name,last_name,parent_id,deleted_at) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (account_id => accounts.id)
#  fk_rails_...  (parent_id => parents.id)
#
require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
