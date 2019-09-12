class SearchController < ApplicationController
  before_action :authorize_search

  layout 'app'

  def index
    respond_to do |format|
      format.html
      format.json do
        if params[:q].present?
          @variants = policy_scope(Variant).includes(product: :variants).joins(:product)
            .where('LOWER(code) LIKE LOWER(:q) OR LOWER(products.title) LIKE LOWER(:q)', q: "%#{params[:q]}%")
        end
      end
    end
  end

  private

  def authorize_search
    authorize :search
  end
end
