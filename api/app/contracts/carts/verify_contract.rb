# frozen_string_literal: true

module Carts
  class VerifyContract < ApplicationContract
    params do
      required(:code).filled(:string)
      required(:phone).filled(:phone)
    end
  end
end
