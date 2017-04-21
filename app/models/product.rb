class Product < ApplicationRecord
  COLORS = %w(red yellow green blue pink white black gray)

  mount_uploaders :images, ImageUploader

  has_many :kitables
  has_many :kits, through: :kitables

  has_many :lookables, as: :lookable
  # has_many :looks, through: :lookables

  belongs_to :category

  class << self
    def faker_images
      require 'json'
      require 'open-uri'

      images = []
      (1..19).each do |page|
        s = JSON.parse open("https://www.kitandace.com/ca/en/search/results/?rootCategory=women&text=&page=#{page}").read
        s['results'].each do |p|
          images << p['defaultColorProduct']['descriptionMedias'][0]['url']
        end
      end
      images
    end
  end
end
