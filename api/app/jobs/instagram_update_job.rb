# frozen_string_literal: true

class InstagramUpdateJob < ApplicationJob
  queue_as :default

  def perform
    Instagram::UpdateCmd.call
  end
end
