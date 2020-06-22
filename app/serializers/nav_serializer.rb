class NavSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :slug, :title

  attribute :type do |nav|
    nav.class.name
  end
end
