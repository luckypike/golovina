# frozen_string_literal: true

module Sessions
  class DecodeJwtCmd < ApplicationCmd
    input :jwt
    output :user

    def call
      token = decode_jwt(jwt)
      self.user = find_user(token.first["sub"])
    rescue JWT::VerificationError, ActiveRecord::RecordNotFound, JWT::DecodeError
      self.user = nil
    end

    private

    def decode_jwt(token)
      JWT.decode(
        token,
        OpenSSL::PKey::RSA.new(Figaro.env.auth_public_key),
        true, { algorithm: "RS256" }
      )
    end

    def find_user(id)
      Api::User.find(id)
    end
  end
end
