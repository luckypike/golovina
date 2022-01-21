if @posts
  json.posts @posts[0..5] do |post|
    json.extract! post, :id, :media_type, :media_url, :permalink
  end
end
