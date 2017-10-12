# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://#{Rails.application.secrets[:host]}"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #

  Product.where(state: [:active, :archived]).find_each do |product|
    add polymorphic_path(product), lastmod: product.updated_at
  end

  Category.find_each do |category|
    add category_products_path(slug: category.slug), lastmod: Time.now
  end

  Theme.find_each do |theme|
    add polymorphic_path(theme), lastmod: Time.now
  end
end
