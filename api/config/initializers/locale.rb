# frozen_string_literal: true

I18n.load_path += Dir[Rails.root.join("lib/locale/*.{rb,yml}")]
I18n.load_path += Dir[Rails.root.join("config/locales/**/*.{rb,yml}")]

I18n.default_locale = :ru
I18n.available_locales = %i[ru en]

class I18nComponentMount < React::Rails::ComponentMount
  def react_component(name, props = {}, options = {}, &block)
    props[:locale] = I18n.locale
    props[:aws] = {
      endpoint: ENV["aws_endpoint"],
      bucket: ENV["aws_bucket"]
    }

    # props[:i18n] = {
    #   locale: I18n.locale,
    #   default_locale: I18n.default_locale,
    #   available_locales: I18n.available_locales
    # }

    super
  end
end

Rails.application.configure do
  config.i18n.fallbacks = [I18n.default_locale]

  config.react.view_helper_implementation = I18nComponentMount
end
