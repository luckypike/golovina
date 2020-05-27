json.posts @posts.with_indifferent_access[:data][0..5] do |post|
  json.extract! post, :id, :media_type, :media_url, :permalink
end
