class LooksController < ApplicationController
  before_action :set_look, only: [:show, :edit, :update, :destroy]

  # GET /looks
  def index
    @looks = Look.all
  end

  # GET /looks/1
  def show
  end

  # GET /looks/new
  def new
    @look = Look.new
  end

  # GET /looks/1/edit
  def edit
  end

  # POST /looks
  def create
    @look = Look.new(look_params)

    if @look.save
      redirect_to @look, notice: 'Look was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /looks/1
  def update
    if @look.update(look_params)
      redirect_to @look, notice: 'Look was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /looks/1
  def destroy
    @look.destroy
    redirect_to looks_url, notice: 'Look was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_look
      @look = Look.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def look_params
      params.require(:look).permit(:title)
    end
end
