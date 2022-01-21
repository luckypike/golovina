# frozen_string_literal: true

module Images
  class CreateContract < ApplicationContract
    params do
      required(:file).filled(:string)
      required(:uuid).filled(:string)
    end
  end
end
