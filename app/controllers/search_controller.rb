class SearchController < ApplicationController
  before_action :authorize_search

  layout 'app'

  def index
    respond_to do |format|
      format.html
      format.json do

      end
    end
  end

  private

  def authorize_search
    authorize :search
  end
end
