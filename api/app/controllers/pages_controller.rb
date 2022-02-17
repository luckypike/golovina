# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :authorize_page

  def robots
    respond_to :text
    expires_in 6.hours, public: true
  end

  # def contacts; end

  private

  def authorize_page
    authorize :page
  end
end
