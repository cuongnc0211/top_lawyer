class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  require "carrierwave/storage/fog"

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :avatar do
    process resize_to_fill: [300, 300]
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end
end
