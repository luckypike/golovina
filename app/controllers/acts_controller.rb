class ActsController < ApplicationController
  def create
    authorize Act

    @act = Act.new(act_params)

    respond_to do |format|
      format.json do
        if @act.save
          head :ok
        else
          render json: @act.errors, status: :unprocessable_entity
        end
      end
    end
  end

  private

  def act_params
    params.require(:act).permit(:store_id, :quantity, :availability_id)
  end
end
