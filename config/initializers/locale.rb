I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}')]

I18n.default_locale = :ru
I18n.available_locales = [:ru, :en]
