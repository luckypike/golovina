class SizesGroupsController < ApplicationController
  before_action :set_sizes_group, only: [:show, :edit, :update, :destroy]

  def index
    authorize SizesGroup

    @sizes_groups = SizesGroup.all
  end

  def show
    authorize @sizes_group
  end

  def new
    @sizes_group = SizesGroup.new
    authorize @sizes_group
  end

  def edit
    authorize @sizes_group
  end

  def create
    @sizes_group = SizesGroup.new(sizes_group_params)
    authorize @sizes_group

    respond_to do |format|
      if @sizes_group.save
        format.html { redirect_to sizes_groups_path, notice: 'Sizes group was successfully created.' }
        format.json { render :show, status: :created, location: @sizes_group }
      else
        format.html { render :new }
        format.json { render json: @sizes_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @sizes_group

    respond_to do |format|
      if @sizes_group.update(sizes_group_params)
        format.html { redirect_to sizes_groups_path, notice: 'Sizes group was successfully updated.' }
        format.json { render :show, status: :ok, location: @sizes_group }
      else
        format.html { render :edit }
        format.json { render json: @sizes_group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @sizes_group

    @sizes_group.destroy
    respond_to do |format|
      format.html { redirect_to sizes_groups_url, notice: 'Sizes group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_sizes_group
      @sizes_group = SizesGroup.find(params[:id])
    end

    def sizes_group_params
      params.require(:sizes_group).permit(:title)
    end
end
