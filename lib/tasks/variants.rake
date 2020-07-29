namespace :variants do
  desc 'TODO'

  task recalc: :environment do
    Availability.includes(:acts).find_each do |availability|
      availability.update(quantity: availability.acts.sum(&:quantity))
    end

    Variant.includes(:availabilities, :acts).find_each do |variant|
      variant.update(
        quantity: variant.availabilities.sum(&:quantity),
        acts_count: variant.acts.size
      )
    end
  end

  task updated_at: :environment do
    Variant.all.each do |variant|
      if variant.images.present?
        variant.update_attribute(:updated_at, variant.images.last.updated_at)
      end
    end
  end

  task convert_video: :environment do
    tmp_dir = Rails.root.join('tmp/video')
    Dir.mkdir(tmp_dir) unless Dir.exist?(tmp_dir)

    Variant
      .joins('INNER JOIN active_storage_attachments video_attachments ON video_attachments.record_id = variants.id AND video_attachments.record_type = \'Variant\' AND video_attachments.name = \'video\'')
      .joins('LEFT JOIN active_storage_attachments video_mp4_attachments ON video_mp4_attachments.record_id = variants.id AND video_mp4_attachments.record_type = \'Variant\' AND video_mp4_attachments.name = \'video_mp4\'')
      .where(video_mp4_attachments: { record_id: nil })
      .where.not(video_attachments: { record_id: nil })
      .each do |variant|
        mp4_video_path = Rails.root.join("tmp/video/#{variant.video.key}.mp4")
        video = FFMPEG::Movie.new(variant.video.service_url)
        File.delete(mp4_video_path) if File.exist?(mp4_video_path)
        video.transcode(
          mp4_video_path.to_s,
          {
            resolution: '900x1200', video_bitrate: 1200, video_bitrate_tolerance: 200,
            aspect: 0.75,
            custom: %w[-vf scale=900:-1,crop=900:1200:0:ih/2-600]
          }
        )

        variant.video_mp4.attach(io: File.open(mp4_video_path), filename: variant.video.filename)

        File.delete(mp4_video_path) if File.exist?(mp4_video_path)
    end
  end

  # task images: :environment do
  #   Variant.where(state: :archived).each do |variant|
  #     if (Time.now - variant.updated_at) / 86400 > 59
  #       variant.images.each do |image|
  #         image.destroy
  #       end
  #     end
  #   end
  # end
end
