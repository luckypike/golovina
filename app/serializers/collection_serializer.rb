class CollectionSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :slug, :title, :desc
end
