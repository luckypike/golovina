json.categories(@categories.sort_by{ |c| c.weight }) do |category|
  json.extract! category, :id, :title, :state, :weight
  json.variants do
    json.active category.variants_counter
    json.total category.variants.size
  end

  json.translated category.translations.size == I18n.available_locales.size
end
