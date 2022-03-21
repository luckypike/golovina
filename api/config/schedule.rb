# frozen_string_literal: true

every 15.minutes do
  rake "variants:convert_video"
  rake "slides:convert_video"
  rake "kits:convert_videos"
end
