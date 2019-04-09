class CollectionsController < ApplicationController
  before_action :set_collection, only: [:edit, :update, :destroy, :show]

  layout 'app', except: [:show]

  def show
    authorize @collection

    @photos = Rails.cache.fetch("#{@collection.id}/photos", expires_in: 12.hours) do
      photos = {}

      Dir.glob(File.join('public', 'uploads', 'collections', @collection.id.to_s, "*.jpg"), File::FNM_CASEFOLD).each do |file|
        k, i = File.basename(file.downcase, '.jpg').split('_')
        photos[k] ||= OpenStruct.new
        photos[k].images ||= []

        im = MiniMagick::Image.open(file)

        photos[k].images << {
          id: i,
          pos: (im[:height] > im[:width] ? :vert : :hor)
        }
      end

      photos
    end

    respond_to do |format|
      format.html do
        render 'show_comp', layout: 'layouts/app' if @collection.images.any?
      end
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

    @collections = Collection.all
  end

  private
  def set_collection
    @collection = Collection.friendly.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:title, :slug, :desc, :text, :weight, image_ids: [])
  end
end
