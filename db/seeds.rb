# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'

categories = YAML.load_file('db/categories.yml')

categories.each_with_index do |(slug, c), id|
  category = Category.where(id: id + 1).first_or_initialize
  category.title = c['title']
  category.slug = slug
  category.desc = c['desc']
  category.save
end

categories = Category.all
images = Product::faker_images

(0..500).each do |id|
  product = Product.where(id: id + 1).first_or_initialize
  product.title = Faker::Commerce.product_name
  product.price = Faker::Commerce.price
  product.desc = Faker::Lorem.paragraph
  product.category = categories.sample
  product.remote_images_urls = [images.sample]
  product.save
end

products = Product.all

Kitable.destroy_all

(0..14).each do |id|
  kit = Kit.where(id: id + 1).first_or_initialize
  kit.title = Faker::Commerce.product_name
  kit.products = products.sample(rand(2..5))
  kit.save
end

looks = YAML.load_file('db/looks.yml')

Lookable.destroy_all

kits = Kit.all

looks.each_with_index do |(slug, c), id|
  look = Look.where(id: id + 1).first_or_initialize
  look.title = c['title']
  look.products = products.sample(rand(10..20))
  look.kits = kits.sample(rand(1..3))
  look.save
end