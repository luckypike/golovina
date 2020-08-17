namespace :kits do
  desc 'TODO'

  task convert_video: :environment do
    tmp_dir = Rails.root.join('tmp/video')
    Dir.mkdir(tmp_dir) unless Dir.exist?(tmp_dir)

    Kit
      .joins('INNER JOIN active_storage_attachments video_attachments ON video_attachments.record_id = kits.id AND video_attachments.record_type = \'Kit\' AND video_attachments.name = \'video\'')
      .joins('LEFT JOIN active_storage_attachments video_mp4_attachments ON video_mp4_attachments.record_id = kits.id AND video_mp4_attachments.record_type = \'Kit\' AND video_mp4_attachments.name = \'video_mp4\'')
      .where(video_mp4_attachments: { record_id: nil })
      .where.not(video_attachments: { record_id: nil })
      .each do |kit|
        mp4_video_path = Rails.root.join("tmp/video/#{kit.video.key}.mp4")
        video = FFMPEG::Movie.new(kit.video.service_url)
        File.delete(mp4_video_path) if File.exist?(mp4_video_path)
        video.transcode(
          mp4_video_path.to_s,
          {
            resolution: '900x1200', video_bitrate: 1200, video_bitrate_tolerance: 200,
            aspect: 0.75,
            custom: %w[-an -vf scale=900:-1,crop=900:1200:0:ih/2-600]
          }
        )

        kit.video_mp4.attach(io: File.open(mp4_video_path), filename: kit.video.filename)

        File.delete(mp4_video_path) if File.exist?(mp4_video_path)
    end
  end
end
