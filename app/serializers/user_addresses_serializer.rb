class UserAddressesSerializer
  include FastJsonapi::ObjectSerializer

  attributes :country, :city, :street, :house, :appartment
end
