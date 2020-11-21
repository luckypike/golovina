class CertsController < ApplicationController
  before_action :set_cert, only: :pay
  before_action :authorize_cert
  before_action :set_guest_user, only: %i[index]

  def index; end

  def create
    sleep 1

    @cert = Cert.new(cert_params)
    @cert.amount = 1
    @cert.discount_type = :flat
    @cert.code = Devise.friendly_token.first(4).upcase
    @cert.user.assign_attributes({ state: :common })

    respond_to do |format|
      format.json do
        if @cert.save
          render json: @cert.slice(:id), status: :ok, location: pay_cert_path(@cert)
        else
          render json: @cert.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def pay
    render layout: false
  end

  private

  def set_cert
    @cert = Cert.find(params[:id])
  end

  def authorize_cert
    authorize Cert || @cert
  end

  def cert_params
    params.require(:cert).permit(
      :discount, :email, :user_id,
      user_attributes: %i[name sname email phone]
    )
  end
end
