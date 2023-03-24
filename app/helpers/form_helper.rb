# frozen_string_literal: true

module FormHelper
  def link_to_add_fields(form_object, association, &block)
    new_object = form_object.object.send(association).klass.new
    id = new_object.object_id
    fields = form_object.fields_for(association, new_object, child_index: id) do |builder|
      render("#{association.to_s.singularize}_fields", f: builder)
    end

    link_to('#', class: 'add_fields d-grid gap-2', data: { id:, fields: }, &block)
  end
end
