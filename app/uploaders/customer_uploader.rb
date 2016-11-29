# encoding: utf-8

class CustomerUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog
  process :resize_to_fill => [266, 165]
  # process :resize_to_fill => [194, 120]
  # process :resize_to_fill => [130, 80]
  # process :resize_to_fill => [80, 50] - mobile

  def store_dir
    path = "cliente/#{model.id}/logomarca"

    # if Rails.env.development?
    #   path = "development/#{path}"
    # end

    path
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
