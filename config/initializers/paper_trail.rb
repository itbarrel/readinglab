# frozen_string_literal: true

PaperTrail.config.enabled = true
PaperTrail.config.version_limit = 10
PaperTrail.config.serializer = PaperTrail::Serializers::JSON
