class CategorySerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :slug, :title
end
