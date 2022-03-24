# frozen_string_literal: true

module Sessions
  class SendCodeBySmsContract < ApplicationContract
    params do
      required(:phone).filled(:phone)
    end
  end
end
