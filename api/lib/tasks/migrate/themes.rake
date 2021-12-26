namespace :themes do
  desc 'Move from boolean fields'

  task migrate: :environment do
    %i[latest bestseller sale premium linen spec basic last].each do |slug|
      theme = Theme.where(slug: slug).first_or_create(state: :active)
      theme.title_ru = I18n.t("variants.#{slug}.title", locale: :ru)
      theme.title_en = I18n.t("variants.#{slug}.title", locale: :en)
      theme.save

      slug = :stayhome if slug == :basic

      theme.themables.delete_all

      Variant.not_archived.where("#{slug}": true).order(pinned: :desc, created_at: :desc)
        .each_with_index do |variant, weight|
        theme.themables.create(variant: variant, weight: weight)
      end
    end

    Variant.order(pinned: :desc, created_at: :desc).not_archived
      .group_by(&:category).each do |category, category_variants|
      category_variants.each_with_index do |variant, weight|
        variant.update(weight: weight)
      end
    end
  end
end
