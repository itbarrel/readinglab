# frozen_string_literal: true

json.array! @form_details, partial: 'form_details/form_detail', as: :form_detail
