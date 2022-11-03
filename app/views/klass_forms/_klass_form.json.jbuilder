# frozen_string_literal: true

json.extract! klass_form, :id, :deleted_at, :form_id, :klass_id, :created_at, :updated_at
json.url klass_form_url(klass_form, format: :json)
