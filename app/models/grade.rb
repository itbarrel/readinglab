# frozen_string_literal: true

# == Schema Information
#
# Table name: grades
#
#  id         :uuid             not null, primary key
#  deleted_at :datetime
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Grade < ApplicationRecord
end
