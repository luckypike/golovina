class CollectionsController < ApplicationController
  before_action :set_collection, only: %i[edit update show]

  def show
    authorize @collection

    respond_to do |format|
      format.html
      format.json
    end
  end

  def new
    @collection = Collection.new
    authorize @collection
  end

  def edit
    authorize @collection
  end

  def create
    @collection = Collection.new(collection_params)
    authorize @collection

    if @collection.save
      head :created, location: collections_path
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  def update
    authorize @collection

    if @collection.update(collection_params)
      head :ok, location: collection_path(@collection.id)
    else
      render json: @collection.errors, status: :unprocessable_entity
    end
  end

  def index
    authorize Collection
    collection = Collection.active.order(weight: :asc, id: :desc).first
    redirect_to collection_path(id: collection.slug), status: :found
  end

  private

  def set_collection
    @collection = Collection.friendly.find(params[:id])
  end

  def collection_params
    permitted =
      Collection.globalize_attribute_names \
      + %i[title text desc text weight] \
      + [
        image_ids: %i[]
      ] \
      + [
        images_attributes: %i[id weight]
      ]

    params.require(:collection).permit(*permitted)
  end
end
