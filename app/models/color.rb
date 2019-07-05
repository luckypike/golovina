class Color < ApplicationRecord
  mount_uploader :image, ColorUploader

  # extend FriendlyId

  # validates_presence_of :slug
  # validates_uniqueness_of :slug

  # friendly_id :title, use: :slugged

  belongs_to :parent_color, class_name: 'Color', optional: true
  has_many :colors, class_name: "Color", foreign_key: "parent_color_id"

  class << self
    def tree exclude = false
      tree = []
      colors = where(parent_color: nil).order(title: :asc)
      colors = colors.where.not(id: exclude) if exclude.present?
      colors.each do |color|
        tree << color
        if color.colors.size > 0
          color.colors.each do |color_color|
            color_color.title = '-- ' + color_color.title
            tree << color_color
          end
        end
      end
      tree
    end
  end
end
