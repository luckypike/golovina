class KindsController < ApplicationController
  before_action :set_kind, only: [:show, :edit, :update, :destroy]

  # GET /kinds
  def index
    @kinds = Kind.all
  end

  # GET /kinds/1
  def show
  end

  # GET /kinds/new
  def new
    @kind = Kind.new
  end

  # GET /kinds/1/edit
  def edit
  end

  # POST /kinds
  def create
    @kind = Kind.new(kind_params)

    if @kind.save
      redirect_to @kind, notice: 'Kind was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /kinds/1
  def update
    if @kind.update(kind_params)
      redirect_to @kind, notice: 'Kind was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /kinds/1
  def destroy
    @kind.destroy
    redirect_to kinds_url, notice: 'Kind was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kind
      @kind = Kind.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def kind_params
      params.require(:kind).permit(:title, :category_id)
    end
end
