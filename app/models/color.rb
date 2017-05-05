class Color < ApplicationRecord
  extend FriendlyId

  # validates_presence_of :slug
  # validates_uniqueness_of :slug

  friendly_id :title, use: :slugged

  belongs_to :parent_color, class_name: 'Color', optional: true

end
