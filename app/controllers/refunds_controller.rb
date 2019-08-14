class RefundsController < ApplicationController
  # skip_before_action :verify_authenticity_token, only: [:paid]

  layout 'app'

  def index
    authorize Refund

    respond_to do |format|
      format.html
      format.json do
        @orders = Order.includes(:user, order_items: { variant: [ { product: [:images, :category] }, :color, :images ]}).where(user: Current.user, state: [:active, :paid, :archived])
      end
    end
  end

  def create
    @refund = Refund.new(refund_params)
    authorize @refund

    @refund.state = :active
    @refund.user = Current.user

    if @refund.save
      head :ok, location: refunds_user_path(Current.user)
    else
      render :new
    end
  end

  private
  
  def refund_params
    params.require(:refund).permit(:reason, :detail, :order_id, order_item_ids: [])
  end

end
