# encoding: utf-8

class PropertyUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog
  process :resize_to_fill => [730, 486]

  def store_dir
    "imovel/#{model.property_id}/galeria"
  end

  def default_url
    # TODO
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
