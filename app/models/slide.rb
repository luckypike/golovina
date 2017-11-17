class Slide < ApplicationRecord
  mount_uploader :image, SlideUploader
end
