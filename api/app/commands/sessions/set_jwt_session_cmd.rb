# frozen_string_literal: true

module Sessions
  class SetJwtSessionCmd < ApplicationCmd
    input :user
    output :token

    def call
      self.token = create_jwt(user)
    end

    private

    def create_jwt(user)
      JWT.encode(
        { sub: user.id, exp: 1.year.from_now.to_i },
        OpenSSL::PKey::RSA.new(Figaro.env.auth_private_key),
        "RS256"
      )
    end
  end
end
