class AvailabilitiesController < ApplicationController
  before_action :set_variant
  before_action :set_availability, only: %i[destroy]
  before_action :authorize_variant

  def index
    respond_to do |format|
      format.html
      format.json do
        @availabilities = @variant.availabilities
      end
    end
  end

  def create
    @availability = @variant.availabilities
      .where(size: Size.find(availability_params[:size_id])).first_or_initialize

    respond_to do |format|
      format.json do
        if @availability.save
          head :ok
        else
          render json: @availability.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @availability.destroy
    head :ok
  end

  private

  def set_variant
    @variant = Variant.find(params[:variant_id])
  end

  def set_availability
    @availability = @variant.availabilities.find(params[:id])
  end

  def authorize_variant
    authorize @variant, :availabilities?
  end

  def availability_params
    params.require(:availability).permit(:size_id)
  end
end
