class CollectionsController < ApplicationController
  before_action :set_collection, only: [:edit, :update, :destroy, :show]

  def show
    authorize @collection

    @photos = Rails.cache.fetch("#{@collection.id}/photos", expires_in: 12.hours) do
      photos = {}

      Dir.glob(File.join('public', 'uploads', 'collections', @collection.id.to_s, "*.jpg")).each do |file|
        k, i = File.basename(file, '.jpg').split('_')
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
      redirect_to [:collections]
    else
      render :new
    end
  end

  def update
    authorize @collection

    if @collection.update(collection_params)
      redirect_to [:collections]
    else
      render :edit
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
    params.require(:collection).permit(:title, :slug, :text)
  end
end