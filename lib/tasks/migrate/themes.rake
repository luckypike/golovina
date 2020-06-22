namespace :themes do
  desc 'Move from boolean fields'

  task migrate: :environment do
    %i[latest bestseller sale premium linen spec basic last].each do |slug|
      theme = Theme.where(slug: slug).first_or_create(state: :active)
      theme.title_ru = I18n.t("variants.#{slug}.title", locale: :ru)
      theme.title_en = I18n.t("variants.#{slug}.title", locale: :en)
      theme.save

      slug = :stayhome if slug == :basic

      variants = Variant.where("#{slug}": true)
      theme.variants = variants
    end
  end
end
