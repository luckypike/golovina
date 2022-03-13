# frozen_string_literal: true

module Sessions
  class SignInWithAppleIdContract < ApplicationContract
    params do
      required(:token).hash do
        required(:iss).filled(:string)
        required(:sub).filled(:string)
        required(:email).filled(:email)
      end

      optional(:user).hash do
        required(:name).hash do
          required(:firstName).filled(:string)
          required(:lastName).filled(:string)
        end
      end

      required(:referer).filled(:string)
    end
  end
end
