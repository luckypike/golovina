class CertsController < ApplicationController
  before_action :authorize_cert

  def index; end

  def create
    sleep 1

    @cert = Cert.new(cert_params)
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

  private

  def authorize_cert
    authorize Cert
  end

  def cert_params
    params.require(:cert).permit(
      :discount, :email,
      user_attributes: %i[name sname email phone]
    )
  end
end
