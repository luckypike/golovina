class RefundsController < ApplicationController
  before_action :set_refund, only: [:done]

  layout 'app'

  def index
    authorize Refund

    respond_to do |format|
      format.html
      format.json do
        @refunds = Refund.includes(:user, order_items: { variant: [ { product: [:images, :category] }, :color, :images ]}).order(id: :desc)
      end
    end
  end

  def refund
    authorize Refund

    respond_to do |format|
      format.html
      format.json do
        @orders = Order.includes(:user, order_items: { variant: [ { product: [:images, :category] }, :color, :images ]}).where(user: Current.user, state: [:paid, :archived])
      end
    end
  end

  def create
    @refund = Refund.new(refund_params)
    authorize @refund

    @refund.state = :active
    @refund.user = Current.user

    if @refund.save
      OrderMailer.refund(@refund).deliver_later
      head :ok, location: refunds_user_path(Current.user)
    else
      render :new
    end
  end

  def done
    authorize @refund
    @refund.do!
    head :ok
  end

  private
  def set_refund
    @refund = Refund.find(params[:id])
  end

  def refund_params
    params.require(:refund).permit(:reason, :detail, :order_id, order_item_ids: [])
  end

end
