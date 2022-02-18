# frozen_string_literal: true

module Api
  class CartPolicy < Api::ApplicationPolicy
    def show?
      user
    end
  end
end
