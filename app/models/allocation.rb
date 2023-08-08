# frozen_string_literal: true

# == Schema Information
#
# Table name: allocations
#
#  id             :uuid             not null, primary key
#  allocatee_type :string           not null
#  deleted_at     :datetime
#  ends_at        :datetime
#  starts_at      :datetime
#  substance_type :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  allocatee_id   :uuid             not null
#  substance_id   :uuid             not null
#
# Indexes
#
#  index_allocations_on_allocatee  (allocatee_type,allocatee_id)
#  index_allocations_on_substance  (substance_type,substance_id)
#
class Allocation < ApplicationRecord
  belongs_to :allocatee, polymorphic: true
  belongs_to :substance, polymorphic: true

  def self.latest(klass)
    where(substance_type: klass.name).order(created_at: :desc).first
  end
end
