class PhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  process :store_dimensions

  process resize_to_limit: [5000, 5000]

  version :drag do
    process resize_to_fill: [300, 300]
  end

  version :preview do
    process smart_resize: [300, 240]
    process :optimize
  end

  version :thumb do
    process resize_to_fill: [1000, 1250]
    process :optimize
  end

  version :large do
    process resize_to_fill: [2000, 2500]
    process :optimize
  end

  version :post do
    process resize_to_fill: [2000, 3000]
    process :optimize
  end

  version :collection do
    process resize_to_limit: [nil, 1800]
    process :optimize
  end


  # version :cart do
  #   process resize_to_fill: [320, 400]
  #   process :optimize
  # end

  def smart_resize w, h
    width, height = ::MiniMagick::Image.open(file.file)[:dimensions]
    if width > height
      resize_to_fill w, h
    else
      resize_to_fill h, w
    end
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def store_dimensions
    if file && model
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{@model.uuid}.#{file.extension}"
  end
end
