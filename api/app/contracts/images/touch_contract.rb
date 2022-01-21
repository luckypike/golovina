# frozen_string_literal: true

module Images
  class TouchContract < ApplicationContract
    params do
      required(:filename).filled(:string)
      required(:content_type).filled(:string)
      required(:byte_size).filled(:integer)
      required(:checksum).filled(:string)
    end
  end
end
