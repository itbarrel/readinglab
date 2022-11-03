# frozen_string_literal: true

json.array! @receipt_types, partial: 'receipt_types/receipt_type', as: :receipt_type
