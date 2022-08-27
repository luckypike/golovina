# frozen_string_literal: true

module Colors
  class CreateAndUpdateResource
    include Alba::Resource

    root_key :color, :colors

    attributes :id
  end
end
