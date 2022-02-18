# frozen_string_literal: true

module Api
  class SessionsController < Api::ApplicationController
    def show
      authorize %i[api session]
    end
  end
end
