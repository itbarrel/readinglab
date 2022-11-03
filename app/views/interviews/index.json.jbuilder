# frozen_string_literal: true

json.array! @interviews, partial: 'interviews/interview', as: :interview
