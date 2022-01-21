# frozen_string_literal: true

class VariantProcessJob < ApplicationJob
  queue_as :default

  def perform(variant:)
    Variants::ProcessCmd.call(variant: variant)
  end
end
