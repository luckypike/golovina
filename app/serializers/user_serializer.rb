class UserSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :email, :name, :sname, :phone

  attribute :guest, &:guest?
  attribute :common, &:common?
  attribute :editor, &:editor?

  attribute :email do |user|
    user.guest_email? ? '' : user.email
  end

  attribute :reset_password_token, if: proc { |_record, params|
    params && params[:with_reset_password_token]
  }

  attribute :addresses, if: proc { |_record, params|
    params && params[:with_addresses]
  }
end
