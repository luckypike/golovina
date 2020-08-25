class SlideSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :link, :link_relative, :desc

  attribute :image do |slide|
    slide.image.large.url
  end

  attribute :video_mp4 do |slide|
    { key: slide.video_mp4.key } if slide.video_mp4.attached?
  end
end
