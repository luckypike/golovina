# frozen_string_literal: true

class ApplicationContract < Dry::Validation::Contract
  # https://en.wikipedia.org/wiki/E.164
  PHONE_NUMBER_REGEX = /\A\+\d{11,15}\z/.freeze

  # Regexp to check emails against
  EMAIL_REGEX = /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/.freeze

  TypeContainer = Dry::Schema::TypeContainer.new
  TypeContainer.register(
    'params.email',
    Dry::Types['strict.string'].constrained(format: EMAIL_REGEX).constructor { |str| str.downcase.squish }
  )

  config.messages.top_namespace = 'contracts'
  config.messages.default_locale = I18n.default_locale
  config.messages.backend = :i18n
  config.types = TypeContainer
end
