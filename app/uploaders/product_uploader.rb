# encoding: utf-8

class ProductUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog
  process :resize_to_fill => [180, 120]

  def store_dir
    path = "comercio/#{model.market_id}/produto"
    path = "development/#{path}" if Rails.env.development?
  end

  def default_url
    'default.png'
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
  end
end
