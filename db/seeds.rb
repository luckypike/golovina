# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'open-uri'

categories = YAML.load_file('db/categories.yml')

categories.each_with_index do |(slug, c), id|
  category = Category.where(id: id + 1).first_or_initialize
  category.title = c['title']
  category.slug = slug
  category.desc = c['desc']
  category.save
end

colors = YAML.load_file('db/colors.yml')

colors.each_with_index do |(slug, c), id|
  color = Color.where(id: id + 1).first_or_initialize
  color.title = c['title']
  color.slug = slug
  color.desc = c['desc']
  color.save
end

themes = YAML.load_file('db/themes.yml')

themes.each_with_index do |(slug, c), id|
  theme = Theme.where(id: id + 1).first_or_initialize
  theme.title = c['title']
  theme.desc = c['desc']
  theme.slug = slug
  theme.save
end