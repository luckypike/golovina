class PhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

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

  process resize_to_limit: [5000, 5000]

  version :drag do
    process resize_to_fill: [300, 300]
  end

  version :preview do
    process resize_to_fill: [240, 300]
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



  # version :cart do
  #   process resize_to_fill: [320, 400]
  #   process :optimize
  # end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    "#{@model.uuid}.#{file.extension}"
  end
end
