json.themes(@themes.sort_by{ |c| c.weight }) do |theme|
  json.extract! theme, :id, :title, :state, :weight
  json.variants do
    json.total theme.variants.size
  end

  json.translated theme.translations.size == I18n.available_locales.size
end
