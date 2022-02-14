# frozen_string_literal: true

module Api
  class StatusController < Api::ApplicationController
    def index
      skip_authorization

      head :ok
    end
  end
end
