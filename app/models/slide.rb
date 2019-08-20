class Slide < ApplicationRecord
  translates :name
  mount_uploader :image, SlideUploader
end
