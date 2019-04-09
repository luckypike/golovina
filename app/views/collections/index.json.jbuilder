json.collections(@collections) do |collection|
  json.extract! collection, :id, :title, :slug
end
