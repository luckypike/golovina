# frozen_string_literal: true

module Colors
  class IndexResource
    include Alba::Resource

    root_key :color, :colors

    attributes :id, :color

    attribute :title do |r|
      (r.send("title_#{I18n.locale}") || "").strip
    end

    attribute :color_image_url do |r|
      r.color_image ? "/s3/#{r.color_image}.jpg" : nil
    end

    many :colors do
      attributes :id, :color

      attribute :title do |r|
        (r.send("title_#{I18n.locale}") || "").strip
      end

      attribute :color_image_url do |r|
        r.color_image ? "/s3/#{r.color_image}.jpg" : nil
      end
    end
  end
end
