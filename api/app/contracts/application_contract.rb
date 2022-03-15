# frozen_string_literal: true

class ApplicationContract < Dry::Validation::Contract
  # https://en.wikipedia.org/wiki/E.164
  PHONE_NUMBER_REGEX = /\A\+\d{11,15}\z/

  # Regexp to check emails against
  EMAIL_REGEX = /\A[^@,\s]+@[^@,\s]+\.[^@,\s]+\z/

  ZIP_REGEX = /\A[0-9]+\z/

  TypeContainer = Dry::Schema::TypeContainer.new
  TypeContainer.register(
    "params.email",
    Dry::Types["strict.string"].constrained(format: EMAIL_REGEX).constructor { |str| str.downcase.squish }
  )

  TypeContainer.register(
    "params.phone",
    Dry::Types["strict.string"].constrained(format: PHONE_NUMBER_REGEX).constructor do |str|
      str = str.gsub(/[^\d]/, "").presence
      str = "+#{str}" if str.present? && !str.start_with?("+")
      # TODO: find the better way
      str[1] = "7" if str.size == 12 && str[1] == "8"
      str
    end
  )

  TypeContainer.register("params.zip", Dry::Types["strict.string"].constrained(format: ZIP_REGEX))

  config.messages.top_namespace = "contracts"
  config.messages.default_locale = I18n.default_locale
  config.messages.backend = :i18n
  config.types = TypeContainer
end
