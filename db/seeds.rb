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