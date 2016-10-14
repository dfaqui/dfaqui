# encoding: utf-8

class PropertyUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    if Rails.env.production?
      "production/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "development/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  process :resize_to_fill => [730, 486]

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
