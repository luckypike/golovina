# frozen_string_literal: true

class CategoryProcessJob < ApplicationJob
  queue_as :default

  def perform(category:)
    Categories::ProcessCmd.call(category: category)
  end
end
