# frozen_string_literal: true

json.array! @vacation_types, partial: 'vacation_types/vacation_type', as: :vacation_type
