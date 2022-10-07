# frozen_string_literal: true

json.array! @receipts, partial: 'receipts/receipt', as: :receipt
