# frozen_string_literal: true

module Subscriptions
  class CreateContract < ApplicationContract
    params do
      required(:email).filled(:email)
      required(:first_name).filled(:string)
      required(:last_name).filled(:string)
      required(:date_of_birth).filled(:date)
      required(:confirm).filled(true)
    end
  end
end
