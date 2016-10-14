# encoding: utf-8

class ProductUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    if Rails.env.production?
      # "production/market/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
      "market/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "development/market/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  process :resize_to_fill => [180, 120]

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
