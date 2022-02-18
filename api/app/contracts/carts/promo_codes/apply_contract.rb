# frozen_string_literal: true

module Carts
  module PromoCodes
    class ApplyContract < ApplicationContract
      params do
        required(:title).filled(:string)
      end
    end
  end
end
