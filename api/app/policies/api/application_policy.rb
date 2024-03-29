# frozen_string_literal: true

module Api
  class ApplicationPolicy
    attr_reader :user, :record

    def new?
      create?
    end

    def edit?
      update?
    end

    def initialize(user, record)
      @user = user
      @record = record
    end
  end
end
