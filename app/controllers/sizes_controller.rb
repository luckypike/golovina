class SizesController < ApplicationController
  before_action :set_size, only: [:edit, :update, :destroy]

  def index
    authorize Size
    @sizes = Size.order(:id).all
  end

  def new
    @size = Size.new
    authorize @size
  end

  def edit
    authorize @size
  end

  def create
    @size = Size.new(size_params)
    authorize @size

    respond_to do |format|
      if @size.save
        format.html { redirect_to sizes_path, notice: 'Size was successfully created.' }
        format.json { render :show, status: :created, location: @size }
      else
        format.html { render :new }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @size

    respond_to do |format|
      if @size.update(size_params)
        format.html { redirect_to sizes_path, notice: 'Size was successfully updated.' }
        format.json { render :show, status: :ok, location: @size }
      else
        format.html { render :edit }
        format.json { render json: @size.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @size

    @size.destroy
    respond_to do |format|
      format.html { redirect_to sizes_url, notice: 'Size was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_size
      @size = Size.find(params[:id])
    end

    def size_params
      params.require(:size).permit(:size, :sizes_group_id)
    end
end
