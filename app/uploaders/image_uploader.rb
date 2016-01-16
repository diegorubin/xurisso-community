# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file
  permissions 0666

  def store_dir
    "assets/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

   def default_url
    ActionController::Base.helpers.image_path("fallback/" + [version_name, "image.png"].compact.join('_'))
   end

  version :thumb do
    process :resize_to_fill => [100, 100]
  end

  version :album do
    process :resize_to_limit => [500,500]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def fix_exif_rotation
    manipulate! do |img|
      img.tap(&:auto_orient)
    end
  end

  process :fix_exif_rotation

end

