# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'open-uri'

categories = YAML.load_file('db/categories.yml')

categories.each_pair do |slug, v|
  category = Category.where(slug: slug).first_or_initialize
  category.title = v['title']
  category.desc = v['desc']
  category.save
end

colors = YAML.load_file('db/colors.yml')

colors.each_pair do |slug, v|
  color = Color.where(slug: slug).first_or_initialize
  color.title = v['title']
  color.desc = v['desc']
  color.save
end

themes = YAML.load_file('db/themes.yml')

themes.each_pair do |slug, v|
  theme = Theme.where(slug: slug).first_or_initialize
  theme.title = v['title']
  theme.title_short = v['title_short']
  theme.desc = v['desc']
  theme.save
end

User.create_with(email: 'we+mint@luckypike.com', password: 'mint11', password_confirmation: 'mint11').find_or_create_by(id: 1)