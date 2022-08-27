# frozen_string_literal: true

def generate_test_jwt(user_id)
  JWT.encode(
    { sub: user_id, exp: 1.year.from_now.to_i },
    OpenSSL::PKey::RSA.new(ENV.fetch("AUTH_PRIVATE_KEY")),
    "RS256"
  )
end
