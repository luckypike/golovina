namespace :kits do
  desc 'TODO'

  task convert_videos: :environment do
    Kit
      .joins('INNER JOIN active_storage_attachments video_attachments ON video_attachments.record_id = kits.id AND video_attachments.record_type = \'Kit\' AND video_attachments.name = \'video\'')
      .joins('LEFT JOIN active_storage_attachments video_mp4_attachments ON video_mp4_attachments.record_id = kits.id AND video_mp4_attachments.record_type = \'Kit\' AND video_mp4_attachments.name = \'video_mp4\'')
      .where(video_mp4_attachments: { record_id: nil })
      .where.not(video_attachments: { record_id: nil })
      .each do |kit|
        ConvertVideoJob.perform_later kit
    end
  end
end
