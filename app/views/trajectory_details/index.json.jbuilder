# frozen_string_literal: true

json.array! @trajectory_details, partial: 'trajectory_details/trajectory_detail', as: :trajectory_detail
