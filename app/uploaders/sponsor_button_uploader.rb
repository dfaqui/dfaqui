# encoding: utf-8

class SponsorButtonUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog
  process :resize_to_fill => [164, 164]

  def store_dir
    "publicidade/botao"
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
