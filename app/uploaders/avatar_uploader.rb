# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file
  permissions 0666

  def store_dir
    "assets/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

   def default_url
    ActionController::Base.helpers.image_path("fallback/" + [version_name, "avatar.png"].compact.join('_'))
   end

  version :microthumb do
    process :resize_to_fill => [20, 20]
  end
  version :thumb do
    process :resize_to_fill => [60, 60]
  end

  version :example do
    process :resize_to_fill => [100,100]
  end

  version :profile do
    process :resize_to_fill => [188,188]
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

