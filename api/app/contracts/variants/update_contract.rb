# frozen_string_literal: true

module Variants
  class UpdateContract < ApplicationContract
    params do
      required(:email).filled(:string)
      required(:age).value(:integer)
    end
  end
end
