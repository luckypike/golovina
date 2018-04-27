class DiscountsController < ApplicationController
  before_action :set_discount, only: [:edit, :update, :destroy]

  def index
    authorize Discount
    @discounts = Discount.order(:id).all
  end

  def new
    @discount = Discount.new
    authorize @discount
  end

  def edit
    authorize @discount
  end

  def create
    @discount = Discount.new(discount_params)
    authorize @discount

    respond_to do |format|
      if @discount.save
        format.html { redirect_to discounts_path, notice: 'Discount was successfully created.' }
        format.json { render :show, status: :created, location: @discount }
      else
        format.html { render :new }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @discount

    p discount_params
    respond_to do |format|
      if @discount.update(discount_params)
        format.html { redirect_to discounts_path, notice: 'Discount was successfully updated.' }
        format.json { render :show, status: :ok, location: @discount }
      else
        format.html { render :edit }
        format.json { render json: @discount.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @discount

    @discount.destroy
    respond_to do |format|
      format.html { redirect_to discounts_url, notice: 'Discount was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_discount
      @discount = Discount.find(params[:id])
    end

    def discount_params
      params.require(:discount).permit(:name, :phone, :size, :user_id)
    end
end
