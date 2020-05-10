class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :email, :name, :sname

  attribute :guest, &:guest?
  attribute :common, &:common?
end
