# frozen_string_literal: true

module Carts
  class CheckoutContract < ApplicationContract
    params do
      required(:name).filled(:string)
      required(:sname).filled(:string)
      required(:phone).filled(:phone)
      required(:email).filled(:email)
      optional(:comment).maybe(:string)
    end
  end
end
