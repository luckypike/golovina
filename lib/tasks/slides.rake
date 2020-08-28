namespace :slides do
  desc 'TODO'

  task convert_video: :environment do
    tmp_dir = Rails.root.join('tmp/video')
    Dir.mkdir(tmp_dir) unless Dir.exist?(tmp_dir)

    Slide
      .joins('INNER JOIN active_storage_attachments video_attachments ON video_attachments.record_id = slides.id AND video_attachments.record_type = \'Slide\' AND video_attachments.name = \'video\'')
      .joins('LEFT JOIN active_storage_attachments video_mp4_attachments ON video_mp4_attachments.record_id = slides.id AND video_mp4_attachments.record_type = \'Slide\' AND video_mp4_attachments.name = \'video_mp4\'')
      .where(video_mp4_attachments: { record_id: nil })
      .where.not(video_attachments: { record_id: nil })
      .each do |slide|
        mp4_video_path = Rails.root.join("tmp/video/#{slide.video.key}.mp4")
        video = FFMPEG::Movie.new(slide.video.service_url)

        next unless video.valid?

        File.delete(mp4_video_path) if File.exist?(mp4_video_path)
        video.transcode(
          mp4_video_path.to_s,
          {
            resolution: '900x1200', video_bitrate: 1700,
            aspect: 0.75,
            custom: %w[-an -vf scale='max(900,ih/4*3)':'max(1200,iw/3*4)',crop=900:1200:iw/2-450:ih/2-600]
          }
        )

        slide.video_mp4.attach(io: File.open(mp4_video_path), filename: slide.video.filename)

        File.delete(mp4_video_path) if File.exist?(mp4_video_path)
    end
  end
end
