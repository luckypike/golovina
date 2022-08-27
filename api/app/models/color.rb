# frozen_string_literal: true

class Color < ApplicationRecord
  scope :main, -> { where(parent_color: nil) }

  # mount_uploader :image, ColorUploader

  belongs_to :parent_color, class_name: "Color", optional: true
  has_many :colors, class_name: "Color", foreign_key: :parent_color_id
  has_many :variants

  validates :title_ru, :title_en, presence: true
  validates :parent_color, absence: true, if: -> { colors.any? }
  validates :color, presence: true, unless: -> { image.presence }

  def main?
    !parent_color_id
  end

  def title
    (send("title_#{I18n.locale}") || "").strip
  end

  def image_url
    "/s3/#{color_image}.webp"
  end
end
