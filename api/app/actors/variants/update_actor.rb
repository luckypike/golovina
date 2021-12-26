# frozen_string_literal: true

module Variants
  class UpdateActor < ApplicationActor
    input :variant_params

    def call
      params = validate_contract(UpdateContract, variant_params)
    end
  end
end
