# frozen_string_literal: true

json.extract! klass_tempelate_form, :id, :deleted_at, :klass_tempelate_id, :form_id, :created_at, :updated_at
json.url klass_tempelate_form_url(klass_tempelate_form, format: :json)
