# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def false?(obj)
    [false, 'false'].include?(obj)
  end

  def true?(obj)
    [true, 'true'].include?(obj)
  end

  def admins?(user)
    user.admin? || user.supervisor?
  end

  def validate_uuid_format(uuid)
    uuid_regex = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
    return true if uuid_regex.match?(uuid.to_s.downcase)

    false
    # log_and_raise_error("Given argument is not a valid UUID: '#{format_argument_output(uuid)}'")
  end

  def seconds_to_days(seconds)
    days = seconds / (24 * 60 * 60)
    days.floor
  end

  def render_partial_if_exists(partial)
    render partial: partial if lookup_context.exists?(partial, [], true)
  end
end
