# frozen_string_literal: true

class ApplicationContract < Dry::Validation::Contract
  config.messages.top_namespace = 'contracts'
  config.messages.default_locale = I18n.default_locale
  config.messages.backend = :i18n
end
