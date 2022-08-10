# frozen_string_literal: true

class ConvertVideoJob < ApplicationJob
  queue_as :default

  # TODO: Check this method
  def perform(object) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    object.update(video_mp4: nil, video_poster: nil)

    tmp_dir = Rails.root.join("tmp/video")
    FileUtils.mkdir_p(tmp_dir)

    video = FFMPEG::Movie.new(object.video.service_url)
    video_mp4_path = Rails.root.join("tmp/video/#{object.video.key}.mp4")
    video_poster_path = Rails.root.join("tmp/video/#{object.video.key}.jpg")

    return unless video.valid?

    FileUtils.rm_rf(video_mp4_path)
    FileUtils.rm_rf(video_poster_path)

    video.transcode(
      video_mp4_path.to_s,
      {
        video_bitrate: 1700,
        custom: %w[-an -vf scale='900:1200:force_original_aspect_ratio=increase',crop=900:1200:iw/2-450:ih/2-600]
      }
    )

    video.screenshot(
      video_poster_path.to_s,
      {
        seek_time: 0,
        quality: 1,
        custom: %w[-an -vf scale='900:1200:force_original_aspect_ratio=increase',crop=900:1200:iw/2-450:ih/2-600]
      }
    )

    object.video_mp4.attach(io: File.open(video_mp4_path), filename: object.video.filename)
    object.video_poster.attach(io: File.open(video_poster_path), filename: object.video.filename)

    FileUtils.rm_rf(video_mp4_path)
    FileUtils.rm_rf(video_poster_path)
  end
end
