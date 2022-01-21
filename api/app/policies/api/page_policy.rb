# frozen_string_literal: true

module Api
  class PagePolicy < Api::ApplicationPolicy
    def index?
      true
    end
  end
end
