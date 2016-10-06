# encoding: utf-8

class CustomerCommonUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file if Rails.env.development?
  storage :fog  if Rails.env.production?

  def store_dir
    if Rails.env.production?
      "property/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/property/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  process :resize_to_fit => [180, 120]

  # def filename
  #   "#{secure_token(16)}.#{file.extension}" if original_filename.present?
  # end
  #
  # protected
  #
  # def secure_token(length=16)
  #   model.image_secure_token ||= SecureRandom.hex(length / 2)
  # end
end
