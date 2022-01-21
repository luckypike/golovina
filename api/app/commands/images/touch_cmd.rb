# frozen_string_literal: true

module Images
  class TouchCmd < ApplicationCmd
    input :image_params
    output :blob

    def call
      params = validate_contract!(TouchContract, image_params)

      blob = ActiveStorage::Blob.create_before_direct_upload!(
        **params.slice(:filename, :byte_size, :checksum, :content_type)
      )

      self.blob = blob
    end
  end
end
