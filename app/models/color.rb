class Color < ApplicationRecord
  scope :main, -> { where(parent_color: nil) }

  mount_uploader :image, ColorUploader

  # extend FriendlyId

  # validates_presence_of :slug
  # validates_uniqueness_of :slug

  # friendly_id :title, use: :slugged

  belongs_to :parent_color, class_name: 'Color', optional: true
  has_many :colors, class_name: "Color", foreign_key: "parent_color_id"
end
